#!/bin/bash

set -euo pipefail

# ==============================================================================
# Script para eliminar una instancia EC2 en AWS
# Uso: ./delete_instance.sh [NOMBRE_INSTANCIA | INSTANCE_ID] [--force]
# Ejemplo: ./delete_instance.sh mi-servidor
# Ejemplo: ./delete_instance.sh i-1234567890abcdef0 --force
# ==============================================================================

# Configuración de colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Función para mensajes de log
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

log_step() {
    echo -e "${BLUE}[STEP]${NC} $1"
}

# Función para mostrar uso del script
usage() {
    echo "Uso: $0 [NOMBRE_INSTANCIA | INSTANCE_ID] [--force]"
    echo ""
    echo "Argumentos:"
    echo "  NOMBRE_INSTANCIA - Nombre (tag Name) o ID de la instancia a eliminar"
    echo "  --force         - Eliminar sin confirmación (opcional)"
    echo ""
    echo "Variables de entorno opcionales:"
    echo "  AWS_REGION     - Región de AWS (default: us-east-1)"
    exit 1
}

# Función para verificar pre-requisitos
check_prerequisites() {
    log_step "Verificando pre-requisitos..."
    
    # Verificar que AWS CLI está instalado
    if ! command -v aws &> /dev/null; then
        log_error "AWS CLI no está instalado. Instálalo desde: https://aws.amazon.com/cli/"
        exit 1
    fi
    
    # Verificar que jq está instalado
    if ! command -v jq &> /dev/null; then
        log_error "jq no está instalado. Instálalo para procesar respuestas de AWS CLI."
        exit 1
    fi
    
    # Verificar credenciales de AWS
    if ! aws sts get-caller-identity &> /dev/null; then
        log_error "Credenciales de AWS no configuradas o no válidas. Ejecuta 'aws configure'."
        exit 1
    fi
    
    log_info "Pre-requisitos verificados correctamente."
}

# Función para verificar si la instancia existe y obtener su información
get_instance_info() {
    local identifier="$1"
    local region="${AWS_REGION:-us-east-1}"
    
    # Intentar primero como ID de instancia
    local instance_info
    instance_info=$(aws ec2 describe-instances \
        --instance-ids "$identifier" \
        --region "$region" \
        --query 'Reservations[0].Instances[0]' \
        --output json 2>/dev/null)
    
    if [[ $? -eq 0 && -n "$instance_info" && "$instance_info" != "null" ]]; then
        echo "$instance_info"
        return 0
    fi
    
    # Si no es un ID, buscar por nombre (tag Name)
    instance_info=$(aws ec2 describe-instances \
        --filters "Name=tag:Name,Values=${identifier}" \
        --query 'Reservations[0].Instances[0]' \
        --output json \
        --region "$region" 2>/dev/null)
    
    if [[ $? -eq 0 && -n "$instance_info" && "$instance_info" != "null" ]]; then
        echo "$instance_info"
        return 0
    fi
    
    return 1
}

# Función para verificar si la instancia está en un estado que permite eliminación
can_terminate_instance() {
    local state="$1"
    
    case "$state" in
        running|pending|stopped|stopping|shutting-down)
            return 0
            ;;
        terminated)
            return 1
            ;;
        *)
            return 0
            ;;
    esac
}

# Función para obtener el ID de instancia desde la respuesta
get_instance_id() {
    local instance_info="$1"
    echo "$instance_info" | jq -r '.InstanceId'
}

# Función para obtener el nombre de instancia desde los tags
get_instance_name() {
    local instance_info="$1"
    local name
    name=$(echo "$instance_info" | jq -r '.Tags[] | select(.Key == "Name") | .Value')
    if [[ "$name" == "null" || -z "$name" ]]; then
        name="Sin nombre"
    fi
    echo "$name"
}

# Función para obtener el estado de la instancia
get_instance_state() {
    local instance_info="$1"
    echo "$instance_info" | jq -r '.State.Name'
}

# Función para obtener la IP pública
get_public_ip() {
    local instance_info="$1"
    local ip
    ip=$(echo "$instance_info" | jq -r '.PublicIpAddress')
    if [[ "$ip" == "null" || -z "$ip" ]]; then
        echo "N/A"
    else
        echo "$ip"
    fi
}

# Función para obtener la IP privada
get_private_ip() {
    local instance_info="$1"
    local ip
    ip=$(echo "$instance_info" | jq -r '.PrivateIpAddress')
    if [[ "$ip" == "null" || -z "$ip" ]]; then
        echo "N/A"
    else
        echo "$ip"
    fi
}

# Función para eliminar la instancia EC2
delete_ec2_instance() {
    local instance_id="$1"
    local force="$2"
    local region="${AWS_REGION:-us-east-1}"
    
    log_info "Iniciando eliminación de la instancia: $instance_id"
    
    # Obtener información actualizada de la instancia
    local instance_info
    instance_info=$(aws ec2 describe-instances \
        --instance-ids "$instance_id" \
        --region "$region" \
        --query 'Reservations[0].Instances[0]' \
        --output json)
    
    local state
    state=$(get_instance_state "$instance_info")
    
    # Verificar si la instancia puede ser eliminada
    if ! can_terminate_instance "$state"; then
        log_warn "La instancia ya está en estado: $state"
        return 0
    fi
    
    # Solicitar confirmación si no es forced
    if [[ "$force" != "true" ]]; then
        local instance_name
        instance_name=$(get_instance_name "$instance_info")
        local public_ip
        public_ip=$(get_public_ip "$instance_info")
        local private_ip
        private_ip=$(get_private_ip "$instance_info")
        
        echo ""
        log_warn "Se eliminará la siguiente instancia:"
        echo "  ID:          $instance_id"
        echo "  Nombre:      $instance_name"
        echo "  Estado:      $state"
        echo "  IP Pública:  $public_ip"
        echo "  IP Privada:  $private_ip"
        echo ""
        
        read -p "¿Está seguro que desea eliminar esta instancia? (escriba 'eliminar' para confirmar): " confirm
        
        if [[ "$confirm" != "eliminar" ]]; then
            log_info "Operación cancelada por el usuario."
            exit 0
        fi
    fi
    
    # Terminar la instancia
    log_step "Ejecutando terminación de instancia..."
    aws ec2 terminate-instances \
        --instance-ids "$instance_id" \
        --region "$region" \
        --output json > /dev/null
    
    if [[ $? -ne 0 ]]; then
        log_error "Error al iniciar la terminación de la instancia"
        exit 1
    fi
    
    log_info "Solicitud de terminación enviada para la instancia: $instance_id"
    
    # Esperar a que la instancia se termine completamente
    log_step "Esperando a que la instancia se elimine completamente..."
    aws ec2 wait instance-terminated \
        --instance-ids "$instance_id" \
        --region "$region"
    
    if [[ $? -ne 0 ]]; then
        log_error "Error esperando a que la instancia se termine"
        exit 1
    fi
    
    log_info "=========================================="
    log_info "Instancia eliminada exitosamente"
    log_info "=========================================="
    echo "INSTANCE_ID=$instance_id"
    echo "STATE=terminated"
    echo "REGION=$region"
    log_info "=========================================="
    
    # Limpiar archivos de información si existen
    local info_files
    info_files=$(find . -maxdepth 1 -name "instance_*_info.txt" -type f 2>/dev/null || true)
    
    if [[ -n "$info_files" ]]; then
        log_info "Archivos de información de instancia eliminados."
    fi
}

# Función principal
main() {
    local identifier=""
    local force="false"
    
    # Parsear argumentos
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --force)
                force="true"
                shift
                ;;
            -h|--help)
                usage
                ;;
            *)
                if [[ -z "$identifier" ]]; then
                    identifier="$1"
                else
                    log_error "Argumento desconocido: $1"
                    usage
                fi
                shift
                ;;
        esac
    done
    
    # Verificar que se proporcionó el identificador
    if [[ -z "$identifier" ]]; then
        log_error "Debe especificar el nombre o ID de la instancia."
        usage
    fi
    
    # Verificar pre-requisitos
    check_prerequisites
    
    # Obtener información de la instancia
    log_step "Buscando instancia: $identifier"
    
    local instance_info
    if ! instance_info=$(get_instance_info "$identifier"); then
        log_error "No se encontró ninguna instancia con el identificador: $identifier"
        log_info "Verifique que el nombre o ID sea correcto y que la instancia exista."
        exit 1
    fi
    
    local instance_id
    instance_id=$(get_instance_id "$instance_info")
    
    log_info "Instancia encontrada: $instance_id"
    
    # Eliminar la instancia
    delete_ec2_instance "$instance_id" "$force"
}

# Ejecutar función principal
main "$@"