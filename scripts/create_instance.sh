#!/bin/bash

set -euo pipefail

# ==============================================================================
# Script para crear una instancia EC2 en AWS
# Uso: ./create_instance.sh [NOMBRE_INSTANCIA] [TIPO_INSTANCIA] [KEY_PAIR] [SECURITY_GROUP]
# Ejemplo: ./create_instance.sh mi-servidor t3.micro mi-key-pair sg-default
# ==============================================================================

# Configuración de colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
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

# Función para mostrar uso del script
usage() {
    echo "Uso: $0 [NOMBRE_INSTANCIA] [TIPO_INSTANCIA] [KEY_PAIR] [SECURITY_GROUP] [SUBNET_ID]"
    echo ""
    echo "Argumentos:"
    echo "  NOMBRE_INSTANCIA  - Nombre identificador para la instancia (tag Name)"
    echo "  TIPO_INSTANCIA   - Tipo de instancia EC2 (default: t3.micro)"
    echo "  KEY_PAIR         - Nombre de la key pair para SSH (default: my-key-pair)"
    echo "  SECURITY_GROUP   - ID del security group (default: obtener del entorno)"
    echo "  SUBNET_ID        - ID de la subnet donde crear la instancia"
    echo ""
    echo "Variables de entorno opcionales:"
    echo "  AWS_REGION       - Región de AWS (default: us-east-1)"
    echo "  AMI_ID           - ID de la AMI a usar (default: ami-0c55b159cbfafe1f0 - Amazon Linux 2)"
    exit 1
}

# Función para verificar pre-requisitos
check_prerequisites() {
    log_info "Verificando pre-requisitos..."
    
    # Verificar que AWS CLI está instalado
    if ! command -v aws &> /dev/null; then
        log_error "AWS CLI no está instalado. Instálalo desde: https://aws.amazon.com/cli/"
        exit 1
    fi
    
    # Verificar que jq está instalado (necesario para parsear JSON)
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

# Función para verificar si una instancia ya existe por nombre
instance_exists_by_name() {
    local instance_name="$1"
    local instance_id
    
    instance_id=$(aws ec2 describe-instances \
        --filters "Name=tag:Name,Values=${instance_name}" "Name=instance-state-name,Values=running,pending,stopped,stopping" \
        --query 'Reservations[0].Instances[0].InstanceId' \
        --output text 2>/dev/null || echo "NOT_FOUND")
    
    if [[ "$instance_id" != "NOT_FOUND" ]]; then
        echo "$instance_id"
        return 0
    fi
    return 1
}

# Función para obtener el ID de la AMI por defecto
get_default_ami() {
    local region="${AWS_REGION:-us-east-1}"
    
    # Obtener la AMI más reciente de Amazon Linux 2
    aws ec2 describe-images \
        --owners amazon \
        --filters "Name=name,Values=amzn2-ami-hvm-*-x86_64-gp2" \
        --query 'Images | sort_by(@, &CreationDate) | [-1].ImageId' \
        --output text \
        --region "$region"
}

# Función para crear la instancia EC2
create_ec2_instance() {
    local instance_name="$1"
    local instance_type="${2:-t3.micro}"
    local key_name="${3:-my-key-pair}"
    local security_group_id="$4"
    local subnet_id="$5"
    local region="${AWS_REGION:-us-east-1}"
    local ami_id="${AMI_ID:-$(get_default_ami)}"
    
    log_info "Creando instancia EC2: $instance_name"
    log_info "  Tipo: $instance_type"
    log_info "  AMI: $ami_id"
    log_info "  Key Pair: $key_name"
    log_info "  Security Group: $security_group_id"
    log_info "  Subnet: $subnet_id"
    log_info "  Región: $region"
    
    # Verificar que la subnet existe
    local subnet_exists
    subnet_exists=$(aws ec2 describe-subnets \
        --subnet-ids "$subnet_id" \
        --query 'Subnets[0].SubnetId' \
        --output text 2>/dev/null || echo "NOT_FOUND")
    
    if [[ "$subnet_exists" == "NOT_FOUND" ]]; then
        log_error "La subnet $subnet_id no existe en la región $region"
        exit 1
    fi
    
    # Verificar que el security group existe
    local sg_exists
    sg_exists=$(aws ec2 describe-security-groups \
        --group-ids "$security_group_id" \
        --query 'SecurityGroups[0].GroupId' \
        --output text 2>/dev/null || echo "NOT_FOUND")
    
    if [[ "$sg_exists" == "NOT_FOUND" ]]; then
        log_error "El security group $security_group_id no existe en la región $region"
        exit 1
    fi
    
    # Verificar que la key pair existe
    local key_exists
    key_exists=$(aws ec2 describe-key-pairs \
        --key-names "$key_name" \
        --query 'KeyPairs[0].KeyName' \
        --output text 2>/dev/null || echo "NOT_FOUND")
    
    if [[ "$key_exists" == "NOT_FOUND" ]]; then
        log_error "La key pair $key_name no existe en la región $region"
        exit 1
    fi
    
    # Crear la instancia
    local instance_id
    instance_id=$(aws ec2 run-instances \
        --image-id "$ami_id" \
        --instance-type "$instance_type" \
        --key-name "$key_name" \
        --security-group-ids "$security_group_id" \
        --subnet-id "$subnet_id" \
        --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${instance_name}},{Key=Environment,Value=dev}]" \
        --output json \
        --region "$region" \
        --query 'Instances[0].InstanceId' \
        2>&1)
    
    if [[ $? -ne 0 ]]; then
        log_error "Error al crear la instancia: $instance_id"
        exit 1
    fi
    
    log_info "Instancia creada con ID: $instance_id"
    
    # Esperar a que la instancia esté en estado running
    log_info "Esperando a que la instancia esté en estado running..."
    aws ec2 wait instance-running \
        --instance-ids "$instance_id" \
        --region "$region"
    
    if [[ $? -ne 0 ]]; then
        log_error "Error esperando a que la instancia esté running"
        exit 1
    fi
    
    # Obtener información de la instancia
    local instance_info
    instance_info=$(aws ec2 describe-instances \
        --instance-ids "$instance_id" \
        --region "$region" \
        --query 'Reservations[0].Instances[0]' \
        --output json)
    
    local public_ip
    public_ip=$(echo "$instance_info" | jq -r '.PublicIpAddress // "N/A"')
    local private_ip
    private_ip=$(echo "$instance_info" | jq -r '.PrivateIpAddress')
    local state
    state=$(echo "$instance_info" | jq -r '.State.Name')
    
    log_info "=========================================="
    log_info "Instancia creada exitosamente"
    log_info "=========================================="
    echo "INSTANCE_ID=$instance_id"
    echo "INSTANCE_NAME=$instance_name"
    echo "INSTANCE_TYPE=$instance_type"
    echo "STATE=$state"
    echo "PUBLIC_IP=$public_ip"
    echo "PRIVATE_IP=$private_ip"
    echo "REGION=$region"
    log_info "=========================================="
    
    # Guardar información en archivo para referencia
    local output_file="instance_${instance_name}_info.txt"
    cat > "$output_file" << EOF
INSTANCE_ID=$instance_id
INSTANCE_NAME=$instance_name
INSTANCE_TYPE=$instance_type
STATE=$state
PUBLIC_IP=$public_ip
PRIVATE_IP=$private_ip
REGION=$region
CREATED_AT=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
EOF
    
    log_info "Información guardada en: $output_file"
    
    echo "$instance_id"
}

# Función principal
main() {
    # Verificar pre-requisitos
    check_prerequisites
    
    # Verificar argumentos mínimos
    if [[ $# -lt 5 ]]; then
        log_error "Argumentos insuficientes."
        usage
    fi
    
    local instance_name="$1"
    local instance_type="$2"
    local key_pair="$3"
    local security_group="$4"
    local subnet_id="$5"
    
    # Verificar si la instancia ya existe
    if instance_exists_by_name "$instance_name"; then
        log_warn "Ya existe una instancia con el nombre '$instance_name'"
        read -p "¿Desea crear otra instancia con el mismo nombre? (s/n): " confirm
        if [[ "$confirm" != "s" && "$confirm" != "S" ]]; then
            log_info "Operación cancelada por el usuario."
            exit 0
        fi
    fi
    
    # Crear la instancia
    create_ec2_instance "$instance_name" "$instance_type" "$key_pair" "$security_group" "$subnet_id"
}

# Ejecutar función principal
main "$@"