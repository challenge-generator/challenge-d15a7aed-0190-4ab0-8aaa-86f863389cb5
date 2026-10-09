# Prompt para Mejorar el Codigo Base

Copia y pega el contenido del bloque de abajo en un asistente de IA (Claude, ChatGPT)
para obtener un ZIP con el proyecto completo y arrancable.

Si preferis trabajar en tu editor con un agente local (Claude Code, Cursor, Copilot), usa `AGENTS.md` en vez de este archivo: dice lo mismo pero para que escriba los archivos en disco.

## Las dos reglas que no se negocian

1. **Completa el boilerplate.** Todo lo que el proyecto necesita para compilar y arrancar: manifiesto de dependencias, punto de entrada, configuracion, capa de interfaz, y las capas del patron arquitectonico declarado. Eso es andamiaje y es tu trabajo.
2. **NO resuelvas el reto.** Los entregables de las fases son el trabajo de la persona. El hueco pedagogico se deja como esta: el proyecto arranca, pero lo que el reto pide implementar NO esta implementado.

Dicho de otra forma: si algo impide compilar, arreglalo. Si algo es logica de negocio incompleta, validaciones ausentes, un secreto hardcodeado o un patron mejorable, dejalo exactamente como esta — es lo que la persona tiene que encontrar.

## Como saber que terminaste

```bash
terraform init -backend=false && terraform validate && terraform fmt -check
```

Ese comando corriendo sin errores es la definicion de "listo".

---

```
## Briefing del reto (autoridad)
Este bloque manda sobre los archivos adjuntos. El stack y el rol salen de AQUÍ, no de un topic genérico ni de markdown placeholder.

### Perfil
Chapter Cloud Ops, Especialidad Analista, Tecnología Cloud Infrastructure, Advanced

### Brecha de conocimiento
Realiza actividades de administración de los servicios en nube entendiendo el ecosistema de funcionamiento y puede desarrollar scripts básicos para creación de la infraestructura y las actividades operativas requeridas.

### Misión / candidato
Candidato con experiencia en infraestructura en la nube

### Reto
- Tema: Administración básica de infraestructura
- Seniority: advanced-l1
- Tipo: practical
- Título: Gestión de infraestructura en la nube
- Tiempo estimado: 8 horas

### Fases (trabajo del HUMANO — PROHIBIDO completarlas)
No implementes estos entregables. Dejalos como hueco pedagógico. El asistente solo materializa el proyecto arrancable para que el participante pueda trabajar.
- Fase 1: Configuración inicial de la infraestructura — objetivo: Establecer una infraestructura básica en la nube que incluya una red virtual, una instancia de máquina virtual y un servicio de almacenamiento. — entregable (NO resolver): Documentación de la configuración inicial de la infraestructura en la nube.
- Fase 2: Desarrollo de scripts de administración — objetivo: Crear scripts básicos para la gestión de la infraestructura creada, incluyendo la creación y eliminación de recursos. — entregable (NO resolver): Scripts de administración de la infraestructura en la nube.
- Fase 3: Monitoreo y optimización — objetivo: Implementar un sistema de monitoreo para la infraestructura y realizar optimizaciones basadas en los datos recolectados. — entregable (NO resolver): Informe de monitoreo y optimización de la infraestructura en la nube.

Eres un asistente experto en análisis, corrección y generación de archivos de cualquier tipo:
código fuente, documentación, hojas de cálculo, documentos Word, configuraciones, entre otros.
Voy a enviarte una cadena de texto que contiene uno o más archivos. Cada archivo está delimitado por un marcador con el siguiente formato:
// === ARCHIVO: ruta/del/archivo.extension ===
o también puede aparecer como:
## === ARCHIVO: ruta/del/archivo.extension ===
Lo que sigue al marcador puede ser:

El contenido real del archivo (código, texto, YAML, etc.)
Una descripción en lenguaje natural de lo que debe contener el archivo


TU TAREA
PASO 0 — ¿Esto es un proyecto o una carcasa?
Antes de extraer archivos, leé el Briefing (si está) y diagnosticá el adjunto.

Es CARCASA si ocurre CUALQUIERA de estas:
- No hay manifiesto de dependencias del stack del briefing (manifest.json de VTEX IO / package.json / pom.xml / build.gradle / requirements.txt / go.mod / *.tf / *.csproj, según corresponda)
- Hay un "binario" que en realidad es un comentario ("no puede ser mostrado como texto plano", placeholder .fig/.docx vacío)
- Los markdowns ya completan entregables de fases posteriores ("se implementó fade-in", lista de áreas ya resuelta)

Si es CARCASA:
- MATERIALIZÁ un proyecto que arranca en el stack del briefing (VTEX IO Store Framework, Angular, Terraform, pytest, Nest, etc.). Incluí manifiesto, punto de entrada y capa de interfaz reales.
- NO copies los markdowns de "solución" como si fueran el producto. Son ruido de generación.
- NO resuelvas las fases del briefing (están marcadas PROHIBIDO). Dejá el hueco pedagógico: el flujo existe, las microinteracciones/calidad/infra que el reto pide NO están hechas.
- Después seguí al PASO 5 (ZIP).

Si es un proyecto REAL (manifiesto + código que compila o arranca):
- Seguí PASO 1 en adelante. 🔴 compilación sí. 🟡 pedagógico no.

PASO 1 — Detección y extracción
Identifica todos los archivos presentes en la cadena. Para cada archivo extrae:

Su ruta completa (ej: src/main/java/com/pragma/Service.java)
Su contenido o descripción

PASO 2 — Clasificación por tipo
Clasifica cada archivo en una de estas categorías:
A) Código fuente (Java, Python, TypeScript, JavaScript, Kotlin, etc.)
B) Configuración / documentación (YAML, properties, Markdown, JSON, txt, etc.)
C) Excel (.xlsx, .xls, .csv)
D) Word (.docx, .doc)
E) Otro tipo de archivo binario o especial
PASO 3 — Clasificación de errores en código fuente

Objetivo prioritario: que el proyecto compile. No corrijas flujo de negocio ni lógica funcional.

Antes de modificar cualquier archivo de código fuente, clasifica cada problema encontrado en una de estas dos categorías:
🔴 ERROR DE COMPILACIÓN — corregir siempre
Son errores que impiden que el proyecto arranque, sin valor pedagógico:

Import faltante o incorrecto
Clase, método o variable referenciada que no existe en ningún archivo del proyecto
Error de sintaxis
Anotación con atributos inválidos
Dependencia ausente en pom.xml, package.json, etc.
Archivo referenciado que no existe y debe ser creado con implementación mínima

→ CORREGIR estos errores.
🟡 PROBLEMA FUNCIONAL O DE CALIDAD — preservar siempre
Son problemas que no impiden compilar. Pueden ser intencionales para el aprendizaje:

Clave secreta hardcodeada ("secret", "password123")
API deprecada que funciona pero tiene reemplazo moderno
Lógica de negocio incorrecta o incompleta
Código redundante o de baja legibilidad
Falta de validaciones en flujo de negocio
Patrones de diseño incorrectos pero funcionales
Concurrencia no segura
Configuración funcional pero no óptima

→ PRESERVAR tal cual. No corregir, no mejorar, no comentar.
PASO 4 — Procesamiento según tipo de archivo
Tipo A — Código fuente
Aplica únicamente las correcciones clasificadas como 🔴 ERROR DE COMPILACIÓN.
No alteres ningún elemento clasificado como 🟡 PROBLEMA FUNCIONAL O DE CALIDAD.
Si falta un archivo referenciado, créalo con la implementación mínima necesaria para compilar.
Tipo B — Configuración / documentación
Extrae el contenido tal cual, sin modificaciones salvo errores evidentes de sintaxis
(ej: YAML mal indentado).
Tipo C — Excel (.xlsx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un archivo Excel funcional con:

Fila de encabezados en negrita con color de fondo distintivo
Columnas con ancho ajustado al contenido
Tipos de dato correctos por columna
Validaciones si la descripción lo indica
Hojas nombradas descriptivamente si hay más de una
Filas de ejemplo si no hay datos reales

Tipo D — Word (.docx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un documento Word funcional con:

Estilos de título (Título 1, Título 2) para jerarquía de secciones
Fuente legible (Calibri o equivalente), tamaño 11-12pt para cuerpo
Márgenes estándar
Tabla de contenido si tiene múltiples secciones
Tablas con encabezados en negrita si aplica

Tipo E — Otro
Genera el archivo con el contenido o estructura más apropiada según la descripción.
PASO 5 — Exportación en ZIP
Empaqueta todos los archivos en un único archivo ZIP descargable respetando exactamente
la estructura de rutas indicada por los marcadores.
El ZIP debe incluir:

Archivos de código con únicamente los errores de compilación corregidos
Archivos de configuración y documentación sin cambios
Archivos nuevos creados para resolver dependencias de compilación faltantes
Archivos Excel y Word generados desde descripción

IMPORTANTE: El ZIP debe estar listo para descargar al finalizar. No preguntes si el usuario
quiere generarlo. Simplemente genera el archivo y proporciona el enlace de descarga; No debes desplegar en el chat el resumen de lo que arreglaste al Zip, solo entregalo.

REGLAS IMPORTANTES

No omitas ningún archivo aunque no tenga errores ni modificaciones
Respeta los nombres y rutas exactas indicadas por los marcadores
Si un archivo no tiene marcador claro, infiere el nombre desde su contenido
Si la cadena contiene solo documentación, placeholders o binarios fake, NO la reproduzcas:
aplicá PASO 0 (materializar el proyecto del briefing). Reproducir la carcasa es un fallo.
No agregues texto después del enlace de descarga del ZIP
No preguntes si el usuario quiere el ZIP: simplemente generalo siempre
Si detectas que falta un archivo de configuración necesario para compilar
(pom.xml, package.json, requirements.txt, build.gradle, etc.), créalo e inclúyelo
inferiendo su contenido desde los imports y frameworks detectados en el código
Nunca corrijas problemas 🟡 aunque parezcan obvios o fáciles de mejorar.
El participante que recibirá este proyecto los debe encontrar y resolver él mismo.


INPUT
Aquí está la cadena con los archivos:

// === ARCHIVO: variables.tf ===
variable "aws_region" {
  description = "La región de AWS donde se desplegará la infraestructura"
  type        = string
}

variable "environment" {
  description = "El ambiente de despliegue (dev, qa, prod)"
  type        = string
}

variable "vpc_cidr" {
  description = "El bloque CIDR para la VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "Lista de bloques CIDR para subredes públicas"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "Lista de bloques CIDR para subredes privadas"
  type        = list(string)
}

variable "instance_type" {
  description = "El tipo de instancia EC2"
  type        = string
}

variable "ami_id" {
  description = "El ID de la AMI para las instancias EC2"
  type        = string
}

variable "key_name" {
  description = "El nombre de la clave SSH para acceder a las instancias EC2"
  type        = string
}

variable "bucket_name" {
  description = "El nombre del bucket S3"
  type        = string
}

variable "cloudwatch_alarm_name" {
  description = "El nombre de la alarma de CloudWatch"
  type        = string
}

variable "cloudwatch_metric_name" {
  description = "El nombre de la métrica de CloudWatch"
  type        = string
}

variable "cloudwatch_namespace" {
  description = "El namespace de la métrica de CloudWatch"
  type        = string
}

variable "cloudwatch_comparison_operator" {
  description = "El operador de comparación para la alarma de CloudWatch"
  type        = string
  default     = "GreaterThanThreshold"
}

variable "cloudwatch_evaluation_periods" {
  description = "El número de periodos de evaluación para la alarma de CloudWatch"
  type        = number
  default     = 2
}

variable "cloudwatch_period" {
  description = "La duración en segundos de cada periodo de evaluación para la alarma de CloudWatch"
  type        = number
  default     = 300
}

variable "cloudwatch_statistic" {
  description = "La estadística a aplicar a la métrica para la alarma de CloudWatch"
  type        = string
  default     = "Average"
}

variable "cloudwatch_threshold" {
  description = "El valor umbral para la alarma de CloudWatch"
  type        = number
  default     = 80
}

variable "tags" {
  description = "Etiquetas para los recursos de AWS"
  type        = map(string)
  default     = {}
}

variable "enable_dns_support" {
  description = "Habilitar soporte DNS en la VPC"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Habilitar nombres de host DNS en la VPC"
  type        = bool
  default     = true
}

variable "map_public_ip_on_launch" {
  description = "Asignar IP pública automáticamente al lanzar instancias en subredes públicas"
  type        = bool
  default     = true
}

variable "s3_force_destroy" {
  description = "Permitir la destrucción del bucket S3 incluso si contiene objetos"
  type        = bool
  default     = false
}

variable "s3_versioning_enabled" {
  description = "Habilitar versionamiento en el bucket S3"
  type        = bool
  default     = true
}

// === ARCHIVO: providers.tf ===
terraform {
  required_version = ">= 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = merge(
      var.tags,
      {
        Environment = var.environment
        ManagedBy   = "Terraform"
      }
    )
  }
}

# Configuración adicional para manejo de errores en la inicialización del provider
# y validación de credenciales antes de proceder con la creación de recursos
locals {
  aws_account_id = data.aws_caller_identity.current.account_id
}

data "aws_caller_identity" "current" {}

# Validación de región soportada
data "aws_regions" "available" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

locals {
  valid_regions = data.aws_regions.available.names
}

# Verificación de que la región especificada es válida
resource "null_resource" "validate_region" {
  triggers = {
    region = var.aws_region
  }

  provisioner "local-exec" {
    command = <<EOT
      if [[ ! " ${local.valid_regions[@]} " =~ " ${var.aws_region} " ]]; then
        echo "Error: La región '${var.aws_region}' no es válida o no está disponible."
        exit 1
      fi
    EOT
    interpreter = ["bash", "-c"]
  }
}

# Configuración de proveedor alternativo para operaciones en otras regiones si es necesario
provider "aws" {
  alias  = "secondary"
  region = "us-east-1" # Región secundaria para servicios globales como IAM
}

// === ARCHIVO: modules/vpc/variables.tf ===
variable "vpc_cidr" {
  description = "El bloque CIDR para la VPC"
  type        = string
  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "El CIDR de la VPC debe ser una dirección CIDR válida (ejemplo: 10.0.0.0/16)."
  }
}

variable "public_subnet_cidrs" {
  description = "Lista de bloques CIDR para subredes públicas"
  type        = list(string)
  validation {
    condition = alltrue([
      for cidr in var.public_subnet_cidrs : can(cidrhost(cidr, 0))
    ])
    error_message = "Todos los CIDRs de subredes públicas deben ser válidos."
  }
}

variable "private_subnet_cidrs" {
  description = "Lista de bloques CIDR para subredes privadas"
  type        = list(string)
  validation {
    condition = alltrue([
      for cidr in var.private_subnet_cidrs : can(cidrhost(cidr, 0))
    ])
    error_message = "Todos los CIDRs de subredes privadas deben ser válidos."
  }
}

variable "enable_dns_support" {
  description = "Habilitar soporte DNS en la VPC"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Habilitar nombres de host DNS en la VPC"
  type        = bool
  default     = true
}

variable "map_public_ip_on_launch" {
  description = "Asignar IP pública automáticamente al lanzar instancias en subredes públicas"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Etiquetas para los recursos de la VPC"
  type        = map(string)
  default     = {}
}

variable "environment" {
  description = "El ambiente de despliegue (dev, qa, prod)"
  type        = string
}

variable "availability_zones" {
  description = "Lista de zonas de disponibilidad para crear subredes"
  type        = list(string)
  default     = []
}

variable "create_nat_gateway" {
  description = "Indica si se debe crear un NAT Gateway para las subredes privadas"
  type        = bool
  default     = true
}

variable "nat_gateway_single" {
  description = "Indica si se debe crear un solo NAT Gateway para todas las subredes privadas"
  type        = bool
  default     = false
}

// === ARCHIVO: modules/ec2/variables.tf ===
variable "instance_type" {
  description = "El tipo de instancia EC2"
  type        = string
  validation {
    condition     = contains(["t3.micro", "t3.small", "t3.medium", "m5.large", "m5.xlarge"], var.instance_type)
    error_message = "El tipo de instancia debe ser uno de: t3.micro, t3.small, t3.medium, m5.large, m5.xlarge."
  }
}

variable "ami_id" {
  description = "El ID de la AMI para las instancias EC2"
  type        = string
  validation {
    condition     = length(var.ami_id) > 4 && substr(var.ami_id, 0, 4) == "ami-"
    error_message = "El AMI ID debe comenzar con 'ami-'."
  }
}

variable "key_name" {
  description = "El nombre de la clave SSH para acceder a las instancias EC2"
  type        = string
}

variable "subnet_id" {
  description = "El ID de la subred donde se lanzará la instancia EC2"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "Lista de IDs de grupos de seguridad para la instancia EC2"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Etiquetas para la instancia EC2"
  type        = map(string)
  default     = {}
}

variable "environment" {
  description = "El ambiente de despliegue (dev, qa, prod)"
  type        = string
}

variable "instance_count" {
  description = "Número de instancias EC2 a crear"
  type        = number
  default     = 1
}

variable "user_data" {
  description = "Script de user data para la instancia EC2"
  type        = string
  default     = ""
}

variable "root_block_device" {
  description = "Configuración del bloque de dispositivo raíz"
  type = object({
    volume_size = number
    volume_type = string
    encrypted   = bool
  })
  default = {
    volume_size = 8
    volume_type = "gp2"
    encrypted   = false
  }
}

variable "ebs_optimized" {
  description = "Indica si la instancia debe estar optimizada para EBS"
  type        = bool
  default     = false
}

// === ARCHIVO: modules/s3/variables.tf ===
variable "bucket_name" {
  description = "El nombre del bucket S3"
  type        = string
  validation {
    condition     = length(var.bucket_name) >= 3 && length(var.bucket_name) <= 63 && can(regex("^[a-z0-9][a-z0-9-.]*[a-z0-9]$", var.bucket_name))
    error_message = "El nombre del bucket debe tener entre 3 y 63 caracteres, comenzar y terminar con una letra minúscula o número, y solo contener letras minúsculas, números, puntos y guiones."
  }
}

variable "tags" {
  description = "Etiquetas para el bucket S3"
  type        = map(string)
  default     = {}
}

variable "environment" {
  description = "El ambiente de despliegue (dev, qa, prod)"
  type        = string
}

variable "force_destroy" {
  description = "Permitir la destrucción del bucket S3 incluso si contiene objetos"
  type        = bool
  default     = false
}

variable "versioning_enabled" {
  description = "Habilitar versionamiento en el bucket S3"
  type        = bool
  default     = true
}

variable "server_side_encryption_enabled" {
  description = "Habilitar cifrado del lado del servidor en el bucket S3"
  type        = bool
  default     = true
}

variable "block_public_acls" {
  description = "Bloquear ACLs públicas en el bucket S3"
  type        = bool
  default     = true
}

variable "block_public_policy" {
  description = "Bloquear políticas públicas en el bucket S3"
  type        = bool
  default     = true
}

variable "ignore_public_acls" {
  description = "Ignorar ACLs públicas en el bucket S3"
  type        = bool
  default     = true
}

variable "restrict_public_buckets" {
  description = "Restringir buckets públicos en el bucket S3"
  type        = bool
  default     = true
}

variable "lifecycle_rules" {
  description = "Reglas de ciclo de vida para el bucket S3"
  type = list(object({
    id                                     = string
    enabled                                = bool
    prefix                                 = string
    tags                                   = map(string)
    transition                             = list(object({
      days          = number
      storage_class = string
    }))
    expiration = object({
      days = number
    })
    noncurrent_version_transition = list(object({
      days          = number
      storage_class = string
    }))
    noncurrent_version_expiration = object({
      days = number
    })
  }))
  default = []
}

// === ARCHIVO: modules/cloudwatch/variables.tf ===
variable "alarm_name" {
  description = "El nombre de la alarma de CloudWatch"
  type        = string
}

variable "metric_name" {
  description = "El nombre de la métrica de CloudWatch"
  type        = string
}

variable "namespace" {
  description = "El namespace de la métrica de CloudWatch"
  type        = string
}

variable "comparison_operator" {
  description = "El operador de comparación para la alarma de CloudWatch"
  type        = string
  default     = "GreaterThanThreshold"
  validation {
    condition     = contains(["GreaterThanOrEqualToThreshold", "GreaterThanThreshold", "LessThanThreshold", "LessThanOrEqualToThreshold"], var.comparison_operator)
    error_message = "El operador de comparación debe ser uno de: GreaterThanOrEqualToThreshold, GreaterThanThreshold, LessThanThreshold, LessThanOrEqualToThreshold."
  }
}

variable "evaluation_periods" {
  description = "El número de periodos de evaluación para la alarma de CloudWatch"
  type        = number
  default     = 2
}

variable "period" {
  description = "La duración en segundos de cada periodo de evaluación para la alarma de CloudWatch"
  type        = number
  default     = 300
}

variable "statistic" {
  description = "La estadística a aplicar a la métrica para la alarma de CloudWatch"
  type        = string
  default     = "Average"
  validation {
    condition     = contains(["SampleCount", "Average", "Sum", "Minimum", "Maximum"], var.statistic)
    error_message = "La estadística debe ser una de: SampleCount, Average, Sum, Minimum, Maximum."
  }
}

variable "threshold" {
  description = "El valor umbral para la alarma de CloudWatch"
  type        = number
  default     = 80
}

variable "alarm_description" {
  description = "La descripción de la alarma de CloudWatch"
  type        = string
  default     = ""
}

variable "alarm_actions" {
  description = "Lista de acciones a realizar cuando la alarma se dispara"
  type        = list(string)
  default     = []
}

variable "ok_actions" {
  description = "Lista de acciones a realizar cuando la alarma vuelve a OK"
  type        = list(string)
  default     = []
}

variable "insufficient_data_actions" {
  description = "Lista de acciones a realizar cuando la alarma tiene datos insuficientes"
  type        = list(string)
  default     = []
}

variable "dimensions" {
  description = "Dimensiones para la métrica de CloudWatch"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Etiquetas para la alarma de CloudWatch"
  type        = map(string)
  default     = {}
}

variable "environment" {
  description = "El ambiente de despliegue (dev, qa, prod)"
  type        = string
}

variable "treat_missing_data" {
  description = "Cómo tratar los datos faltantes para la alarma"
  type        = string
  default     = "missing"
  validation {
    condition     = contains(["missing", "ignore", "breaching", "notBreaching"], var.treat_missing_data)
    error_message = "El valor debe ser uno de: missing, ignore, breaching, notBreaching."
  }
}

// === ARCHIVO: main.tf ===
terraform {
  required_version = ">= 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# =====================================================
# ORQUESTADOR DE INFRAESTRUCTURA AWS
# Este archivo coordina la creación de recursos usando
# módulos reutilizables para crear una landing zone básica
# =====================================================

# Módulo de VPC - Red virtual con subredes públicas y privadas
module "vpc" {
  source = "./modules/vpc"

  environment           = var.environment
  vpc_cidr              = var.vpc_cidr
  availability_zones   = var.availability_zones
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  enable_nat_gateway   = var.enable_nat_gateway
  single_nat_gateway   = var.single_nat_gateway
  tags                  = var.common_tags
}

# Módulo de EC2 - Instancias de máquina virtual
module "ec2" {
  source = "./modules/ec2"

  environment           = var.environment
  vpc_id                = module.vpc.vpc_id
  subnet_ids            = module.vpc.private_subnet_ids
  instance_type         = var.instance_type
  key_name              = var.key_name
  instance_ami          = var.instance_ami
  user_data             = var.user_data
  security_group_ids    = var.security_group_ids
  tags                  = var.common_tags
  depends_on = [
    module.vpc
  ]
}

# Módulo de S3 - Almacenamiento de objetos
module "s3" {
  source = "./modules/s3"

  environment        = var.environment
  bucket_prefix      = var.bucket_prefix
  enable_versioning  = var.enable_s3_versioning
  enable_encryption  = var.enable_s3_encryption
  lifecycle_rules    = var.s3_lifecycle_rules
  tags               = var.common_tags
}

# Módulo de CloudWatch - Monitoreo y logs
module "cloudwatch" {
  source = "./modules/cloudwatch"

  environment           = var.environment
  log_retention_days    = var.log_retention_days
  alarm_email           = var.alarm_email
  instance_id           = module.ec2.instance_id
  vpc_id                = module.vpc.vpc_id
  tags                  = var.common_tags
  depends_on = [
    module.ec2,
    module.vpc
  ]
}

# =====================================================
# RECURSOS ADICIONALES A NIVEL DE CUENTA
# =====================================================

# Grupo de seguridad adicional para acceso admin
resource "aws_security_group" "admin_access" {
  name        = "${var.environment}-admin-access-sg"
  description = "Grupo de seguridad para acceso administrativo"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "SSH desde IP administrativa"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.admin_ip_range]
  }

  egress {
    description = "Salida a internet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-admin-access"
    }
  )
}

# Policy de etiquetado para optimización de costos
resource "aws_iam_policy" "cost_optimization_tag" {
  name        = "${var.environment}-cost-optimization-policy"
  description = "Política para aplicar etiquetas de costo a recursos"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:CreateTags",
          "ec2:DeleteTags",
          "s3:PutBucketTagging",
          "s3:GetBucketTagging"
        ]
        Resource = "*"
        Condition = {
          StringEquals = {
            "aws:RequestTag/Environment" = [var.environment]
          }
        }
      }
    ]
  })

  tags = var.common_tags
}

# Log group para auditoría de operaciones
resource "aws_cloudwatch_log_group" "audit" {
  name              = "/aws/${var.environment}/audit"
  retention_in_days = var.log_retention_days
  kms_key_id        = var.cloudwatch_kms_key_arn

  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-audit-logs"
    }
  )
}

# Alarma de costo estimado
resource "aws_cloudwatch_metric_alarm" "estimated_charges" {
  alarm_name          = "${var.environment}-estimated-charges-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "EstimatedCharges"
  namespace           = "AWS/Billing"
  period              = "21600"
  statistic           = "Maximum"
  threshold           = var.cost_alert_threshold
  alarm_description   = "Alarma cuando los cargos estimados excedan el umbral"
  treat_missing_data  = "notBreaching"

  dimensions = {
    ServiceName = "AmazonEC2"
  }

  tags = var.common_tags
}

// === ARCHIVO: outputs.tf ===
# =====================================================
# VALORES EXPUESTOS DE LA INFRAESTRUCTURA
# Estos outputs permiten consumir los recursos creados
# desde otros módulos o desde la línea de comandos
# =====================================================

output "vpc_id" {
  description = "ID de la VPC creada"
  value       = module.vpc.vpc_id
}

output "vpc_cidr" {
  description = "Bloque CIDR de la VPC"
  value       = module.vpc.vpc_cidr
}

output "vpc_name" {
  description = "Nombre de la VPC"
  value       = module.vpc.vpc_name
}

output "public_subnet_ids" {
  description = "IDs de las subredes públicas"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs de las subredes privadas"
  value       = module.vpc.private_subnet_ids
}

output "public_subnet_availability_zones" {
  description = "Zonas de disponibilidad de subredes públicas"
  value       = module.vpc.public_subnet_availability_zones
}

output "nat_gateway_ips" {
  description = "IPs elásticas de los NAT Gateways"
  value       = module.vpc.nat_gateway_ips
  sensitive   = true
}

output "instance_id" {
  description = "ID de la instancia EC2 principal"
  value       = module.ec2.instance_id
}

output "instance_private_ip" {
  description = "IP privada de la instancia EC2"
  value       = module.ec2.instance_private_ip
}

output "instance_public_ip" {
  description = "IP pública de la instancia EC2"
  value       = module.ec2.instance_public_ip
}

output "instance_availability_zone" {
  description = "Zona de disponibilidad de la instancia"
  value       = module.ec2.instance_availability_zone
}

output "instance_state" {
  description = "Estado actual de la instancia"
  value       = module.ec2.instance_state
}

output "ec2_security_group_id" {
  description = "ID del grupo de seguridad de EC2"
  value       = module.ec2.security_group_id
}

output "ec2_security_group_name" {
  description = "Nombre del grupo de seguridad de EC2"
  value       = module.ec2.security_group_name
}

output "s3_bucket_names" {
  description = "Nombres de los buckets S3 creados"
  value       = module.s3.bucket_names
}

output "s3_bucket_arns" {
  description = "ARNs de los buckets S3 creados"
  value       = module.s3.bucket_arns
}

output "s3_bucket_domain_names" {
  description = "Nombres de dominio de los buckets S3"
  value       = module.s3.bucket_domain_names
}

output "s3_logs_bucket_name" {
  description = "Nombre del bucket de logs"
  value       = module.s3.logs_bucket_name
}

output "cloudwatch_log_group_name" {
  description = "Nombre del grupo de logs de CloudWatch"
  value       = module.cloudwatch.log_group_name
}

output "cloudwatch_dashboard_name" {
  description = "Nombre del dashboard de CloudWatch"
  value       = module.cloudwatch.dashboard_name
}

output "cloudwatch_alarm_arns" {
  description = "ARNs de las alarmas de CloudWatch"
  value       = module.cloudwatch.alarm_arns
}

output "admin_security_group_id" {
  description = "ID del grupo de seguridad administrativo"
  value       = aws_security_group.admin_access.id
}

output "cost_optimization_policy_arn" {
  description = "ARN de la política de optimización de costos"
  value       = aws_iam_policy.cost_optimization_tag.arn
}

output "audit_log_group_name" {
  description = "Nombre del grupo de logs de auditoría"
  value       = aws_cloudwatch_log_group.audit.name
}

output "estimated_charges_alarm_arn" {
  description = "ARN de la alarma de cargos estimados"
  value       = aws_cloudwatch_metric_alarm.estimated_charges.arn
}

output "region" {
  description = "Región de AWS donde se despliega la infraestructura"
  value       = var.aws_region
}

output "environment" {
  description = "Ambiente de despliegue"
  value       = var.environment
}

output "all_resources_created" {
  description = "Confirmation de que todos los recursos fueron creados"
  value       = "Infraestructura completa desplegada en ${var.environment} para la región ${var.aws_region}"
}

// === ARCHIVO: backend.tf ===
# =====================================================
# CONFIGURACIÓN DEL BACKEND REMOTO
# Almacena el estado de Terraform en S3 con locking
# mediante DynamoDB para entornos colaborativos
# =====================================================

terraform {
  backend "s3" {
    bucket         = "terraform-state-${var.backend_bucket_suffix}"
    key            = "${var.environment}/terraform.tfstate"
    region         = var.aws_region
    encrypt        = true
    dynamodb_table = "terraform-state-lock"

    # Configuración de acceso consistente
    http = {
      retry = {
        max_attempts     = 4
        min_delay_ms     = 100
        max_delay_ms     = 1000
        jitter_percent   = 0.1
      }
    }
  }
}

# =====================================================
# RECURSOS PARA SOPORTE DEL BACKEND
# Estos recursos deben existir antes de usar el backend
# Se crean aquí para facilitar la primera ejecución
# =====================================================

# Bucket S3 para almacenar el estado de Terraform
resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-state-${var.backend_bucket_suffix}"

  tags = merge(
    var.common_tags,
    {
      Name        = "terraform-state-${var.backend_bucket_suffix}"
      Description = "Bucket para almacenamiento del estado de Terraform"
      Purpose     = "terraform-remote-state"
    }
  )
}

# Versionado del bucket de estado
resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Cifrado del bucket de estado
resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Bloqueo público del bucket
resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Tabla DynamoDB para locking del estado
resource "aws_dynamodb_table" "terraform_state_lock" {
  name         = "terraform-state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  ttl {
    attribute_name = "ExpiresAt"
    enabled        = true
  }

  tags = merge(
    var.common_tags,
    {
      Name        = "terraform-state-lock"
      Description = "Tabla de locking para estado de Terraform"
      Purpose     = "terraform-state-lock"
    }
  )
}

# Política de acceso al bucket de estado
resource "aws_s3_bucket_policy" "terraform_state_policy" {
  bucket = aws_s3_bucket.terraform_state.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "DenyUnEncryptedObjectUploads"
        Effect = "Deny"
        Principal = "*"
        Action = "s3:PutObject"
        Resource = "${aws_s3_bucket.terraform_state.arn}/*"
        Condition = {
          StringNotEquals = {
            "s3:x-amz-server-side-encryption" = "AES256"
          }
        }
      },
      {
        Sid = "DenyInsecureTransport"
        Effect = "Deny"
        Principal = "*"
        Action = "s3:*"
        Resource = [
          "${aws_s3_bucket.terraform_state.arn}",
          "${aws_s3_bucket.terraform_state.arn}/*"
        ]
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      }
    ]
  })
}

# Política de acceso a la tabla de locking
resource "aws_dynamodb_table_policy" "terraform_state_lock_policy" {
  name         = aws_dynamodb_table.terraform_state_lock.name
  policy       = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = "*"
        }
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:DeleteItem",
          "dynamodb:DescribeTable"
        ]
        Resource = aws_dynamodb_table.terraform_state_lock.arn
        Condition = {
          Bool = {
            "aws:SecureTransport" = "true"
          }
        }
      }
    ]
  })
}


// === ARCHIVO: README.md ===
# Gestión de Infraestructura en la Nube - AWS Landing Zone

## Descripción del Proyecto

Este proyecto implementa una infraestructura base en AWS utilizando Terraform, diseñada siguiendo las mejores prácticas de una Landing Zone para entornos de producción. La arquitectura contempla la creación de recursos de red, cómputo, almacenamiento y monitoreo de forma modular y reutilizable.

## Estructura del Proyecto

```
.
├── README.md                          # Este archivo
├── main.tf                            # Punto de entrada principal
├── providers.tf                       # Configuración de proveedores
├── variables.tf                       # Declaraciones de variables globales
├── outputs.tf                         # Outputs del root module
├── backend.tf                         # Configuración de backend remoto
├── environments/                      # Configuraciones por ambiente
│   ├── dev/
│   │   └── terraform.tfvars
│   ├── qa/
│   │   └── terraform.tfvars
│   └── prod/
│       └── terraform.tfvars
├── modules/                           # Módulos reutilizables
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── ec2/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── s3/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── cloudwatch/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── scripts/                           # Scripts de administración
    ├── create_instance.sh
    └── delete_instance.sh
```

## Topología de la Infraestructura

```
+------------------------------------------------------------------------------+
|                           AWS ACCOUNT                                        |
|                                                                              |
|  +--------------------+     +-------------------------------------------+    |
|  |      VPC           |     |           SUBNETS                          |    |
|  |  10.0.0.0/16       |     |  +----------------+  +----------------+   |    |
|  |                    |     |  |  Public Subnet |  | Private Subnet |   |    |
|  |  +--------------+  |     |  |  10.0.1.0/24   |  | 10.0.2.0/24    |   |    |
|  |  | Internet     |  |     |  |  (AZ1)         |  | (AZ1)          |   |    |
|  |  | Gateway      |  |     |  +----------------+  +----------------+   |    |
|  |  +--------------+  |     |  +----------------+  +----------------+   |    |
|  |        |          |     |  |  Public Subnet |  | Private Subnet |   |    |
|  |        v          |     |  |  10.0.3.0/24   |  | 10.0.4.0/24    |   |    |
|  |  +--------------+  |     |  |  (AZ2)         |  | (AZ2)          |   |    |
|  |  | NAT Gateway  |  |     |  +----------------+  +----------------+   |    |
|  |  +--------------+  |     |                                           |    |
|  +--------------------+     +-------------------------------------------+    |
|                                    |                                          |
|          +-------------------------+-------------------------+                |
|          |                           |                         |               |
|          v                           v                         v               |
|  +----------------+         +----------------+         +----------------+    |
|  | EC2 Instance   |         | S3 Bucket      |         | CloudWatch     |    |
|  |                |         |                |         | Logs/Metrics   |    |
|  | - Web Server   |         | - App Data     |         |                |    |
|  | - App Tier     |         | - Backups      |         | - Monitoring   |    |
|  | - SSH Access   |         | - Static Assets|        | - Alarms       |    |
|  +----------------+         +----------------+         +----------------+    |
|                                                                              |
|  +----------------------------------------------------------------------+   |
|  |                      SECURITY GROUPS                                |   |
|  |  - EC2: SSH (22), HTTP (80), HTTPS (443)                           |   |
|  |  - S3: Solo acceso desde VPC                                       |   |
|  +----------------------------------------------------------------------+   |
|                                                                              |
+------------------------------------------------------------------------------+
```

## Prerrequisitos

Para utilizar este proyecto necesitas:

1. **Terraform** versión 1.5 o superior
2. **AWS CLI** configurado con credenciales válidas
3. **Acceso a AWS** con permisos para crear recursos

### Instalación de Terraform

```bash
# En macOS con Homebrew
brew install terraform

# En Ubuntu/Debian
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor > /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
apt update && apt install terraform

# Verificar instalación
terraform version
```

### Configuración de AWS CLI

```bash
aws configure
# Ingresa tus credenciales cuando se te solicite
# AWS Access Key ID: [tu_access_key]
# AWS Secret Access Key: [tu_secret_key]
# Default region name: us-east-1
# Default output format: json
```

## Uso del Proyecto

### Inicialización

Para descargar los proveedores y preparar el entorno:

```bash
terraform init
```

Este comando descarga el provider de AWS y configura el backend remoto para el estado de Terraform.

### Validación

Para verificar que la configuración es válida:

```bash
terraform validate
```

### Planificación

Para ver los cambios que se aplicarán:

```bash
# Plan para desarrollo
terraform plan -var-file=environments/dev/terraform.tfvars

# Plan para QA
terraform plan -var-file=environments/qa/terraform.tfvars

# Plan para producción
terraform plan -var-file=environments/prod/terraform.tfvars
```

### Aplicación

Para crear los recursos en AWS:

```bash
# Aplicar para desarrollo
terraform apply -var-file=environments/dev/terraform.tfvars

# Aplicar para QA
terraform apply -var-file=environments/qa/terraform.tfvars

# Aplicar para producción (requiere aprobación manual)
terraform apply -var-file=environments/prod/terraform.tfvars
```

### Destrucción

Para eliminar todos los recursos creados:

```bash
# Destruir desarrollo
terraform destroy -var-file=environments/dev/terraform.tfvars
```

## Módulos del Proyecto

### Módulo VPC

Crea la infraestructura de red virtual incluyendo:
- VPC con CIDR configurable
- Subnets públicas y privadas en múltiples AZs
- Internet Gateway para acceso a internet
- NAT Gateways para salida de tráfico desde subnets privadas
- Tablas de enrutamiento apropiadas

### Módulo EC2

Provisiona instancias de máquinas virtuales:
- Instancias EC2 en subnets privadas
- Security Groups con reglas restrictivas
- IAM Roles con permisos mínimos necesarios
- Tags para identificación y costeo

### Módulo S3

Configura buckets de almacenamiento:
- Bucket para datos de aplicación
- Bucket para backups
- Versioning habilitado
- Cifrado AES-256
- Políticas de lifecycle

### Módulo CloudWatch

Implementa monitoreo y observabilidad:
- Log groups para almacenamiento de logs
- Métricas personalizadas
- Alarmas para monitoreo de salud
- Dashboards de visualización

## Ambientes

El proyecto soporta tres ambientes con configuraciones independientes:

| Ambiente | Propósito | Características |
|----------|-----------|------------------|
| dev      | Desarrollo | Recursos pequeños, menor redundancia |
| qa       | Pruebas    | Configuración media, pruebas de integración |
| prod     | Producción | Alta disponibilidad, optimización de costos |

## Variables de Configuración

Las variables principales se configuran en cada archivo `terraform.tfvars` del ambiente correspondiente:

- `environment`: Nombre del ambiente (dev/qa/prod)
- `aws_region`: Región de AWS donde se crearán los recursos
- `vpc_cidr`: Bloque CIDR para la VPC
- `instance_type`: Tipo de instancia EC2
- `instance_count`: Número de instancias a crear

## Scripts de Administración

### create_instance.sh

Script para crear instancias EC2 adicionales:

```bash
./scripts/create_instance.sh <environment> <instance_name>
```

### delete_instance.sh

Script para eliminar instancias EC2:

```bash
./scripts/delete_instance.sh <environment> <instance_name>
```

## Consideraciones de Seguridad

1. **Principio de menor privilegio**: Los roles IAM y security groups usan solo los permisos necesarios
2. **Cifrado**: Todos los datos en reposo están cifrados (S3, EBS)
3. **Red**: Las instancias de aplicación están en subnets privadas
4. **Acceso**: SSH restringido a IP específica o mediante bastion host
5. **Tags**: Todos los recursos tienen etiquetas para identificación y costeo

## Optimización de Costos

- Uso de instancias spot para cargas no críticas
- Lifecycle policies en S3 para mover datos a tier más económico
- Alarmas de CloudWatch para detectar uso excesivo
- Tags para tracking de costos por ambiente y proyecto

## Monitoreo

El sistema de monitoreo incluye:
- Métricas de CPU, memoria y red de EC2
- Logs de aplicación en CloudWatch Logs
- Alarmas para eventos críticos
- Dashboard centralizado en CloudWatch

## Solución de Problemas

### Error de autenticación

Verifica que las credenciales de AWS estén configuradas correctamente:

```bash
aws sts get-caller-identity
```

### Error de estado

Si el estado remoto está bloqueado, verifica que no haya otras ejecuciones de Terraform en curso:

```bash
terraform force-unlock <lock-id>
```

### Recursos pendientes

Si hay recursos huérfanos, límpialos manualmente desde la consola de AWS o usa:

```bash
terraform state list
terraform state rm <resource-address>
```

## Referencias

- [Documentación de Terraform](https://www.terraform.io/docs/)
- [Documentación de AWS](https://docs.aws.amazon.com/)
- [Best Practices de AWS Well-Architected](https://aws.amazon.com/architecture/well-architected/)


// === ARCHIVO: modules/vpc/main.tf ===
terraform {
  required_version = ">= 1.5"
}

# =============================================================================
# VPC Principal - Red virtual donde se aprovisionan los recursos
# =============================================================================
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project}-${var.environment}-vpc"
      Description = "VPC principal para ${var.project} entorno ${var.environment}"
    }
  )
}

# =============================================================================
# Internet Gateway - Permite conectividad outbound a internet
# =============================================================================
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project}-${var.environment}-igw"
      Description = "Internet Gateway para conectividad pública"
    }
  )
}

# =============================================================================
# Subredes Públicas - Para recursos que requieren acceso a internet
# =============================================================================
resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidrs[0]
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project}-${var.environment}-public-subnet-a"
      Type        = "public"
      Description = "Subred pública en zona a"
    }
  )
}

resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidrs[1]
  availability_zone       = "${var.region}b"
  map_public_ip_on_launch = true

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project}-${var.environment}-public-subnet-b"
      Type        = "public"
      Description = "Subred pública en zona b"
    }
  )
}

# =============================================================================
# Subredes Privadas - Para recursos internos sin exposición directa
# =============================================================================
resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidrs[0]
  availability_zone = "${var.region}a"

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project}-${var.environment}-private-subnet-a"
      Type        = "private"
      Description = "Subred privada en zona a"
    }
  )
}

resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidrs[1]
  availability_zone = "${var.region}b"

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project}-${var.environment}-private-subnet-b"
      Type        = "private"
      Description = "Subred privada en zona b"
    }
  )
}

# =============================================================================
# Elastic IPs - IPs elásticas para NAT Gateway en subredes privadas
# =============================================================================
resource "aws_eip" "nat_a" {
  domain = "vpc"

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project}-${var.environment}-eip-nat-a"
      Description = "EIP para NAT Gateway zona a"
    }
  )

  depends_on = [aws_internet_gateway.main]
}

# =============================================================================
# NAT Gateways - Permiten conectividad outbound desde subredes privadas
# =============================================================================
resource "aws_nat_gateway" "main_a" {
  allocation_id = aws_eip.nat_a.id
  subnet_id     = aws_subnet.public_a.id

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project}-${var.environment}-nat-a"
      Description = "NAT Gateway para subredes privadas zona a"
    }
  )

  depends_on = [aws_internet_gateway.main]
}

# =============================================================================
# Tabla de Rutas Pública - Ruta por defecto hacia Internet Gateway
# =============================================================================
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project}-${var.environment}-public-rt"
      Description = "Tabla de rutas pública"
    }
  )
}

# =============================================================================
# Tabla de Rutas Privada - Ruta por defecto hacia NAT Gateway
# =============================================================================
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main_a.id
  }

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project}-${var.environment}-private-rt"
      Description = "Tabla de rutas privada"
    }
  )
}

# =============================================================================
# Asociaciones de Subredes a Tablas de Rutas
# =============================================================================
resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_b" {
  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.private.id
}

# =============================================================================
# Security Group Principal - Reglas de seguridad para la VPC
# =============================================================================
resource "aws_security_group" "main" {
  name        = "${var.project}-${var.environment}-main-sg"
  description = "Security group principal con reglas básicas de acceso"
  vpc_id      = aws_vpc.main.id

  # Reglas de entrada
  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      description = ingress.value.description
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  # Reglas de salida - permitir todo el tráfico saliente
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project}-${var.environment}-main-sg"
      Description = "Security group principal"
    }
  )
}

# =============================================================================
# Security Group para ALB - Permite tráfico HTTP/HTTPS desde internet
# =============================================================================
resource "aws_security_group" "alb" {
  name        = "${var.project}-${var.environment}-alb-sg"
  description = "Security group para Application Load Balancer"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project}-${var.environment}-alb-sg"
      Description = "Security group para ALB"
    }
  )
}

// === ARCHIVO: modules/vpc/outputs.tf ===
# =============================================================================
# Outputs del Módulo VPC - Información expuesta para otros módulos
# =============================================================================

output "vpc_id" {
  description = "ID de la VPC principal"
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "Bloque CIDR de la VPC"
  value       = aws_vpc.main.cidr_block
}

output "vpc_default_security_group_id" {
  description = "ID del security group por defecto de la VPC"
  value       = aws_vpc.main.default_security_group_id
}

output "igw_id" {
  description = "ID del Internet Gateway"
  value       = aws_internet_gateway.main.id
}

output "public_subnet_ids" {
  description = "IDs de las subredes públicas"
  value       = [aws_subnet.public_a.id, aws_subnet.public_b.id]
}

output "public_subnet_cidrs" {
  description = "Bloques CIDR de las subredes públicas"
  value       = [aws_subnet.public_a.cidr_block, aws_subnet.public_b.cidr_block]
}

output "private_subnet_ids" {
  description = "IDs de las subredes privadas"
  value       = [aws_subnet.private_a.id, aws_subnet.private_b.id]
}

output "private_subnet_cidrs" {
  description = "Bloques CIDR de las subredes privadas"
  value       = [aws_subnet.private_a.cidr_block, aws_subnet.private_b.cidr_block]
}

output "main_security_group_id" {
  description = "ID del security group principal"
  value       = aws_security_group.main.id
}

output "alb_security_group_id" {
  description = "ID del security group del ALB"
  value       = aws_security_group.alb.id
}

output "nat_gateway_id" {
  description = "ID del NAT Gateway"
  value       = aws_nat_gateway.main_a.id
}

output "public_route_table_id" {
  description = "ID de la tabla de rutas pública"
  value       = aws_route_table.public.id
}

output "private_route_table_id" {
  description = "ID de la tabla de rutas privada"
  value       = aws_route_table.private.id
}

output "availability_zones" {
  description = "Zonas de disponibilidad utilizadas"
  value       = ["${var.region}a", "${var.region}b"]
}

// === ARCHIVO: modules/ec2/main.tf ===
terraform {
  required_version = ">= 1.5"
}

# =============================================================================
# Instancia EC2 - Máquina virtual en la nube
# =============================================================================
resource "aws_instance" "main" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  # Configuración de red
  vpc_security_group_ids = var.security_group_ids
  associate_public_ip_address = var.associate_public_ip

  # Configuración de almacenamiento
  root_block_device {
    volume_type = var.root_volume_type
    volume_size = var.root_volume_size
    encrypted   = var.encrypt_root_volume
    delete_on_termination = true
  }

  # Metadata de instancia
  lifecycle {
    create_before_destroy = true
  }

  # User data para inicialización básica
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Instance $(hostname -f) - ${var.environment}</h1>" > /var/www/html/index.html
              EOF

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project}-${var.environment}-ec2-${count.index + 1}"
      Description = "Instancia EC2 para ${var.project} entorno ${var.environment}"
      Environment = var.environment
      Project     = var.project
    }
  )

  # Dependencia explícita de la VPC para asegurar orden de creación
  depends_on = [var.vpc_id]
}

# =============================================================================
# Security Group para EC2 - Reglas de acceso a la instancia
# =============================================================================
resource "aws_security_group" "ec2" {
  name        = "${var.project}-${var.environment}-ec2-sg"
  description = "Security group para instancias EC2"
  vpc_id      = var.vpc_id

  # SSH desde IP administrativa
  ingress {
    description     = "SSH from admin network"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks     = var.admin_cidr_blocks
    ipv6_cidr_blocks = []
  }

  # HTTP desde cualquier lugar
  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS desde cualquier lugar
  ingress {
    description = "HTTPS from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Tráfico entre instancias en el mismo security group
  ingress {
    description     = "Self traffic"
    from_port       = -1
    to_port         = -1
    protocol        = "-1"
    self            = true
  }

  # Tráfico hacia internet (salida)
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project}-${var.environment}-ec2-sg"
      Description = "Security group para EC2"
    }
  )
}

# =============================================================================
# Elastic IP - IP pública estática para la instancia
# =============================================================================
resource "aws_eip" "ec2" {
  instance = aws_instance.main.id
  domain   = "vpc"

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project}-${var.environment}-ec2-eip"
      Description = "Elastic IP para instancia EC2"
    }
  )

  depends_on = [aws_instance.main]
}

# =============================================================================
# Volume adicional para datos - Almacenamiento persistente
# =============================================================================
resource "aws_ebs_volume" "data" {
  availability_zone = var.availability_zone
  size              = var.data_volume_size
  type              = var.data_volume_type
  encrypted         = var.encrypt_data_volume

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project}-${var.environment}-ec2-data"
      Description = "Volumen de datos para EC2"
    }
  )
}

# =============================================================================
# Attach del volumen de datos a la instancia
# =============================================================================
resource "aws_volume_attachment" "data_attachment" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.data.id
  instance_id = aws_instance.main.id

  depends_on = [aws_instance.main]
}


// === ARCHIVO: modules/ec2/outputs.tf ===
output "instance_id" {
  description = "ID de la instancia EC2 creada"
  value       = aws_instance.this.id
}

output "instance_public_ip" {
  description = "Dirección IP pública de la instancia EC2"
  value       = aws_instance.this.public_ip
}

output "instance_private_ip" {
  description = "Dirección IP privada de la instancia EC2"
  value       = aws_instance.this.private_ip
}

output "instance_arn" {
  description = "ARN de la instancia EC2"
  value       = aws_instance.this.arn
}

output "instance_primary_network_interface_id" {
  description = "ID de la interfaz de red primaria"
  value       = aws_instance.this.primary_network_interface_id
}

output "instance_security_group" {
  description = "ID del security group asociado a la instancia"
  value       = aws_instance.this.security_groups
}

output "instance_tags" {
  description = "Etiquetas aplicadas a la instancia"
  value       = aws_instance.this.tags
}

output "instance_availability_zone" {
  description = "Zona de disponibilidad donde se aprovisionó la instancia"
  value       = aws_instance.this.availability_zone
}

output "instance_state" {
  description = "Estado actual de la instancia"
  value       = aws_instance.this.instance_state
}

output "ebs_device_name" {
  description = "Nombre del dispositivo EBS attached a la instancia"
  value       = aws_instance.this.root_block_device[0].device_name
}

output "ebs_volume_id" {
  description = "ID del volumen EBS raíz"
  value       = aws_instance.this.root_block_device[0].volume_id
}

output "private_dns" {
  description = "Nombre DNS privado de la instancia"
  value       = aws_instance.this.private_dns
}

output "public_dns" {
  description = "Nombre DNS público de la instancia"
  value       = aws_instance.this.public_dns
}

// === ARCHIVO: modules/s3/main.tf ===
resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name

  tags = merge(
    var.tags,
    {
      Name        = var.bucket_name
      Environment = var.environment
    }
  )
}

resource "aws_s3_bucket_versioning" "this" {
  count  = var.enable_versioning ? 1 : 0
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = var.enable_versioning ? "Enabled" : "Suspended"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = var.sse_algorithm
    }
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

resource "aws_s3_bucket_policy" "allow_access_from_ec2" {
  count  = var.allow_ec2_access ? 1 : 0
  bucket = aws_s3_bucket.this.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "AllowEC2ReadAccess"
        Effect = "Allow"
        Principal = {
          AWS = var.ec2_instance_role_arn
        }
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          aws_s3_bucket.this.arn,
          "${aws_s3_bucket.this.arn}/*"
        ]
      },
      {
        Sid = "AllowEC2WriteAccess"
        Effect = "Allow"
        Principal = {
          AWS = var.ec2_instance_role_arn
        }
        Action = [
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = "${aws_s3_bucket.this.arn}/*"
      }
    ]
  })
}

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  count  = var.enable_lifecycle_rules ? 1 : 0
  bucket = aws_s3_bucket.this.id

  rule {
    id     = "archive_old_objects"
    status = var.enable_lifecycle_rules ? "Enabled" : "Disabled"

    transition {
      days          = var.transition_to_glacier_days
      storage_class = "GLACIER"
    }

    expiration {
      days = var.expiration_days
    }
  }
}

resource "aws_s3_bucket_logging" "this" {
  count  = var.enable_access_logging ? 1 : 0
  bucket = aws_s3_bucket.this.id

  target_bucket = var.logging_target_bucket
  target_prefix = var.logging_target_prefix
}

// === ARCHIVO: modules/s3/outputs.tf ===
output "bucket_id" {
  description = "ID único del bucket S3"
  value       = aws_s3_bucket.this.id
}

output "bucket_arn" {
  description = "ARN del bucket S3"
  value       = aws_s3_bucket.this.arn
}

output "bucket_name" {
  description = "Nombre del bucket S3"
  value       = aws_s3_bucket.this.bucket
}

output "bucket_domain_name" {
  description = "Nombre de dominio del bucket S3"
  value       = aws_s3_bucket.this.bucket_domain_name
}

output "bucket_regional_domain_name" {
  description = "Nombre de dominio regional del bucket S3"
  value       = aws_s3_bucket.this.bucket_regional_domain_name
}

output "bucket_endpoint" {
  description = "Endpoint del bucket S3"
  value       = "https://${aws_s3_bucket.this.bucket_domain_name}"
}

output "bucket_region" {
  description = "Región donde está creado el bucket S3"
  value       = aws_s3_bucket.this.region
}

output "versioning_enabled" {
  description = "Indica si el versionado está habilitado"
  value       = var.enable_versioning
}

output "sse_algorithm" {
  description = "Algoritmo de cifrado usado"
  value       = var.sse_algorithm
}

output "tags" {
  description = "Etiquetas aplicadas al bucket"
  value       = aws_s3_bucket.this.tags
}

output "creation_date" {
  description = "Fecha de creación del bucket"
  value       = aws_s3_bucket.this.creation_date
}


// === ARCHIVO: modules/cloudwatch/main.tf ===
resource "aws_cloudwatch_log_group" "main" {
  name              = "/aws/${var.environment}/${var.project_name}"
  retention_in_days = var.log_retention_days
  kms_key_id        = var.kms_key_arn
  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-log-group"
      Environment = var.environment
      Module      = "cloudwatch"
    }
  )
}

resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "${var.project_name}-cpu-utilization-high-${var.environment}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = var.alarm_period
  statistic           = "Average"
  threshold           = var.cpu_threshold
  alarm_description   = "This metric monitors EC2 CPU utilization"
  alarm_actions       = [aws_sns_topic.alerts.arn]
  ok_actions          = [aws_sns_topic.alerts.arn]
  dimensions = {
    InstanceId = var.instance_id
  }
  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-cpu-alarm"
      Environment = var.environment
      Type        = "metric-alarm"
    }
  )
}

resource "aws_cloudwatch_metric_alarm" "memory_high" {
  alarm_name          = "${var.project_name}-memory-utilization-high-${var.environment}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = "MemoryUtilization"
  namespace           = "System/Linux"
  period              = var.alarm_period
  statistic           = "Average"
  threshold           = var.memory_threshold
  alarm_description   = "This metric monitors memory utilization"
  alarm_actions       = [aws_sns_topic.alerts.arn]
  ok_actions          = [aws_sns_topic.alerts.arn]
  dimensions = {
    InstanceId = var.instance_id
  }
  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-memory-alarm"
      Environment = var.environment
      Type        = "metric-alarm"
    }
  )
}

resource "aws_cloudwatch_metric_alarm" "disk_high" {
  alarm_name          = "${var.project_name}-disk-utilization-high-${var.environment}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = "DiskSpaceUtilization"
  namespace           = "System/Linux"
  period              = var.alarm_period
  statistic           = "Average"
  threshold           = var.disk_threshold
  alarm_description   = "This metric monitors disk space utilization"
  alarm_actions       = [aws_sns_topic.alerts.arn]
  ok_actions          = [aws_sns_topic.alerts.arn]
  dimensions = {
    InstanceId = var.instance_id
  }
  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-disk-alarm"
      Environment = var.environment
      Type        = "metric-alarm"
    }
  )
}

resource "aws_cloudwatch_metric_alarm" "network_in_high" {
  alarm_name          = "${var.project_name}-network-in-high-${var.environment}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = "NetworkIn"
  namespace           = "AWS/EC2"
  period              = var.alarm_period
  statistic           = "Sum"
  threshold           = var.network_threshold
  alarm_description   = "This metric monitors network ingress traffic"
  alarm_actions       = [aws_sns_topic.alerts.arn]
  ok_actions          = [aws_sns_topic.alerts.arn]
  dimensions = {
    InstanceId = var.instance_id
  }
  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-network-in-alarm"
      Environment = var.environment
      Type        = "metric-alarm"
    }
  )
}

resource "aws_cloudwatch_metric_alarm" "network_out_high" {
  alarm_name          = "${var.project_name}-network-out-high-${var.environment}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = "NetworkOut"
  namespace           = "AWS/EC2"
  period              = var.alarm_period
  statistic           = "Sum"
  threshold           = var.network_threshold
  alarm_description   = "This metric monitors network egress traffic"
  alarm_actions       = [aws_sns_topic.alerts.arn]
  ok_actions          = [aws_sns_topic.alerts.arn]
  dimensions = {
    InstanceId = var.instance_id
  }
  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-network-out-alarm"
      Environment = var.environment
      Type        = "metric-alarm"
    }
  )
}

resource "aws_cloudwatch_metric_alarm" "status_check_failed" {
  alarm_name          = "${var.project_name}-status-check-failed-${var.environment}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "StatusCheckFailed"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Maximum"
  threshold           = 0
  alarm_description   = "This metric monitors EC2 status check failures"
  alarm_actions       = [aws_sns_topic.alerts.arn]
  ok_actions          = [aws_sns_topic.alerts.arn]
  dimensions = {
    InstanceId = var.instance_id
  }
  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-status-check-alarm"
      Environment = var.environment
      Type        = "metric-alarm"
      Severity    = "critical"
    }
  )
}

resource "aws_sns_topic" "alerts" {
  name              = "${var.project_name}-alerts-${var.environment}"
  display_name     = "${var.project_name} CloudWatch Alerts"
  kms_master_key_id = var.kms_key_arn
  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-alerts-topic"
      Environment = var.environment
      Module      = "cloudwatch"
    }
  )
}

resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "${var.project_name}-dashboard-${var.environment}"
  dashboard_body = jsonencode({
    widgets = [
      {
        type = "metric"
        properties = {
          metrics = [
            ["AWS/EC2", "CPUUtilization", "InstanceId", var.instance_id],
            [".", "Average"]
          ]
          period = 300
          stat   = "Average"
          region = var.aws_region
          title  = "CPU Utilization"
          annotations = {
            horizontal = [
              {
                value  = var.cpu_threshold
                label  = "CPU Threshold"
                color  = "#ff0000"
              }
            ]
          }
        }
      },
      {
        type = "metric"
        properties = {
          metrics = [
            ["System/Linux", "MemoryUtilization", "InstanceId", var.instance_id],
            [".", "Average"]
          ]
          period = 300
          stat   = "Average"
          region = var.aws_region
          title  = "Memory Utilization"
          annotations = {
            horizontal = [
              {
                value  = var.memory_threshold
                label  = "Memory Threshold"
                color  = "#ff0000"
              }
            ]
          }
        }
      },
      {
        type = "metric"
        properties = {
          metrics = [
            ["AWS/EC2", "NetworkIn", "InstanceId", var.instance_id],
            [".", "Sum"]
          ]
          period = 300
          stat   = "Sum"
          region = var.aws_region
          title  = "Network In"
        }
      },
      {
        type = "metric"
        properties = {
          metrics = [
            ["AWS/EC2", "NetworkOut", "InstanceId", var.instance_id],
            [".", "Sum"]
          ]
          period = 300
          stat   = "Sum"
          region = var.aws_region
          title  = "Network Out"
        }
      },
      {
        type = "metric"
        properties = {
          metrics = [
            ["AWS/EC2", "DiskSpaceUtilization", "InstanceId", var.instance_id, "Path", "/"],
            [".", "Average"]
          ]
          period = 300
          stat   = "Average"
          region = var.aws_region
          title  = "Disk Space Utilization"
          annotations = {
            horizontal = [
              {
                value  = var.disk_threshold
                label  = "Disk Threshold"
                color  = "#ff0000"
              }
            ]
          }
        }
      },
      {
        type = "metric"
        properties = {
          metrics = [
            ["AWS/EC2", "StatusCheckFailed", "InstanceId", var.instance_id],
            [".", "Maximum"]
          ]
          period = 60
          stat   = "Maximum"
          region = var.aws_region
          title  = "Status Check Failed"
        }
      }
    ]
  })
  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-dashboard"
      Environment = var.environment
      Module      = "cloudwatch"
    }
  )
}

resource "aws_cloudwatch_log_metric_filter" "error_filter" {
  name           = "${var.project_name}-error-filter-${var.environment}"
  pattern        = "ERROR"
  log_group_name = aws_cloudwatch_log_group.main.name
  metric_transformation {
    name      = "ErrorCount"
    namespace = "${var.project_name}/Logs"
    value     = "1"
    default_value = "0"
  }
}

resource "aws_cloudwatch_metric_alarm" "error_count" {
  alarm_name          = "${var.project_name}-error-count-high-${var.environment}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ErrorCount"
  namespace           = "${var.project_name}/Logs"
  period              = 60
  statistic           = "Sum"
  threshold           = var.error_threshold
  alarm_description   = "This metric monitors error log count"
  alarm_actions       = [aws_sns_topic.alerts.arn]
  ok_actions          = [aws_sns_topic.alerts.arn]
  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-error-count-alarm"
      Environment = var.environment
      Type        = "log-alarm"
    }
  )
}

resource "aws_cloudwatch_log_metric_filter" "warning_filter" {
  name           = "${var.project_name}-warning-filter-${var.environment}"
  pattern        = "WARNING"
  log_group_name = aws_cloudwatch_log_group.main.name
  metric_transformation {
    name      = "WarningCount"
    namespace = "${var.project_name}/Logs"
    value     = "1"
    default_value = "0"
  }
}

resource "aws_cloudwatch_metric_alarm" "warning_count" {
  alarm_name          = "${var.project_name}-warning-count-high-${var.environment}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "WarningCount"
  namespace           = "${var.project_name}/Logs"
  period              = 300
  statistic           = "Sum"
  threshold           = var.warning_threshold
  alarm_description   = "This metric monitors warning log count"
  alarm_actions       = [aws_sns_topic.alerts.arn]
  ok_actions          = [aws_sns_topic.alerts.arn]
  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-warning-count-alarm"
      Environment = var.environment
      Type        = "log-alarm"
    }
  )
}
// === ARCHIVO: modules/cloudwatch/outputs.tf ===
output "log_group_name" {
  description = "Nombre del grupo de logs de CloudWatch"
  value       = aws_cloudwatch_log_group.main.name
}

output "log_group_arn" {
  description = "ARN del grupo de logs de CloudWatch"
  value       = aws_cloudwatch_log_group.main.arn
}

output "sns_topic_arn" {
  description = "ARN del topic SNS para alertas"
  value       = aws_sns_topic.alerts.arn
}

output "sns_topic_name" {
  description = "Nombre del topic SNS para alertas"
  value       = aws_sns_topic.alerts.name
}

output "cpu_alarm_arn" {
  description = "ARN de la alarma de CPU alto"
  value       = aws_cloudwatch_metric_alarm.cpu_high.arn
}

output "memory_alarm_arn" {
  description = "ARN de la alarma de memoria alta"
  value       = aws_cloudwatch_metric_alarm.memory_high.arn
}

output "disk_alarm_arn" {
  description = "ARN de la alarma de disco alto"
  value       = aws_cloudwatch_metric_alarm.disk_high.arn
}

output "network_in_alarm_arn" {
  description = "ARN de la alarma de tráfico de entrada alto"
  value       = aws_cloudwatch_metric_alarm.network_in_high.arn
}

output "network_out_alarm_arn" {
  description = "ARN de la alarma de tráfico de salida alto"
  value       = aws_cloudwatch_metric_alarm.network_out_high.arn
}

output "status_check_alarm_arn" {
  description = "ARN de la alarma de status check fallido"
  value       = aws_cloudwatch_metric_alarm.status_check_failed.arn
}

output "error_alarm_arn" {
  description = "ARN de la alarma de conteo de errores"
  value       = aws_cloudwatch_metric_alarm.error_count.arn
}

output "warning_alarm_arn" {
  description = "ARN de la alarma de conteo de warnings"
  value       = aws_cloudwatch_metric_alarm.warning_count.arn
}

output "dashboard_name" {
  description = "Nombre del dashboard de CloudWatch"
  value       = aws_cloudwatch_dashboard.main.dashboard_name
}

output "dashboard_url" {
  description = "URL del dashboard de CloudWatch"
  value       = "https://${var.aws_region}.console.aws.amazon.com/cloudwatch/home?region=${var.aws_region}#dashboards:name=${aws_cloudwatch_dashboard.main.dashboard_name}"
}

output "all_alarm_arns" {
  description = "Lista de ARNs de todas las alarmas creadas"
  value = [
    aws_cloudwatch_metric_alarm.cpu_high.arn,
    aws_cloudwatch_metric_alarm.memory_high.arn,
    aws_cloudwatch_metric_alarm.disk_high.arn,
    aws_cloudwatch_metric_alarm.network_in_high.arn,
    aws_cloudwatch_metric_alarm.network_out_high.arn,
    aws_cloudwatch_metric_alarm.status_check_failed.arn,
    aws_cloudwatch_metric_alarm.error_count.arn,
    aws_cloudwatch_metric_alarm.warning_count.arn
  ]
}

output "alarm_names" {
  description = "Lista de nombres de todas las alarmas creadas"
  value = [
    aws_cloudwatch_metric_alarm.cpu_high.alarm_name,
    aws_cloudwatch_metric_alarm.memory_high.alarm_name,
    aws_cloudwatch_metric_alarm.disk_high.alarm_name,
    aws_cloudwatch_metric_alarm.network_in_high.alarm_name,
    aws_cloudwatch_metric_alarm.network_out_high.alarm_name,
    aws_cloudwatch_metric_alarm.status_check_failed.alarm_name,
    aws_cloudwatch_metric_alarm.error_count.alarm_name,
    aws_cloudwatch_metric_alarm.warning_count.alarm_name
  ]
}


// === ARCHIVO: environments/dev/terraform.tfvars ===
# Configuración de variables para el ambiente de desarrollo
# Este archivo define los valores específicos del entorno DEV

environment_name = "dev"

# Configuración de la VPC
vpc_cidr_block           = "10.0.0.0/16"
public_subnet_cidr_1    = "10.0.1.0/24"
public_subnet_cidr_2    = "10.0.2.0/24"
private_subnet_cidr_1   = "10.0.10.0/24"
private_subnet_cidr_2   = "10.0.11.0/24"
availability_zones      = ["us-east-1a", "us-east-1b"]

# Configuración de EC2 para desarrollo
instance_type           = "t3.micro"
instance_ami            = "ami-0c55b159cbfafe1f0"
instance_volume_size    = 20
instance_volume_type    = "gp3"
environment             = "development"

# Configuración de S3 para desarrollo
s3_bucket_name          = "dev-infra-storage-assets"
s3_enable_versioning   = false
s3_enable_encryption    = true
s3_lifecycle_days       = 30

# Configuración de CloudWatch para desarrollo
enable_detailed_monitoring = false
log_retention_days         = 7
alarm_email                = "devops-dev@empresa.com"
cpu_threshold_alarm        = 80
memory_threshold_alarm     = 85

# Etiquetas para optimización de costos
tags = {
  Environment = "development"
  Project     = "infra-gestion"
  CostCenter  = "dev-team"
  ManagedBy   = "terraform"
  Owner       = "cloud-team"
}

# Configuración de alta disponibilidad (desarrollo: menor costo)
enable_multi_az         = false
create_nat_gateway      = true
single_az_instance      = true

// === ARCHIVO: environments/qa/terraform.tfvars ===
# Configuración de variables para el ambiente de QA
# Este archivo define los valores específicos del entorno QA
# Incluye configuraciones más cercanas a producción para pruebas realistas

environment_name = "qa"

# Configuración de la VPC - QA usa subredes más pequeñas pero múltiples AZ
vpc_cidr_block           = "10.1.0.0/16"
public_subnet_cidr_1    = "10.1.1.0/24"
public_subnet_cidr_2    = "10.1.2.0/24"
private_subnet_cidr_1   = "10.1.10.0/24"
private_subnet_cidr_2   = "10.1.11.0/24"
availability_zones      = ["us-east-1a", "us-east-1b"]

# Configuración de EC2 para QA - mayor capacidad que DEV
instance_type           = "t3.small"
instance_ami            = "ami-0c55b159cbfafe1f0"
instance_volume_size    = 30
instance_volume_type    = "gp3"
environment             = "qa"

# Configuración de S3 para QA
s3_bucket_name          = "qa-infra-storage-assets"
s3_enable_versioning   = true
s3_enable_encryption    = true
s3_lifecycle_days       = 60

# Configuración de CloudWatch para QA
enable_detailed_monitoring = true
log_retention_days         = 14
alarm_email                = "devops-qa@empresa.com"
cpu_threshold_alarm        = 75
memory_threshold_alarm     = 80

# Etiquetas para optimización de costos
tags = {
  Environment = "qa"
  Project     = "infra-gestion"
  CostCenter  = "qa-team"
  ManagedBy   = "terraform"
  Owner       = "cloud-team"
}

# Configuración de alta disponibilidad para QA
enable_multi_az         = true
create_nat_gateway      = true
single_az_instance      = false

# Configuración de redundancia y recuperación
enable_deletion_protection = true
backup_retention_days      = 7

// === ARCHIVO: environments/prod/terraform.tfvars ===
# Configuración de variables para el ambiente de producción
# Este archivo define los valores específicos del entorno PROD
# Máxima disponibilidad, seguridad y optimización de costos corporativa

environment_name = "prod"

# Configuración de la VPC - Producción usa CIDR completo con múltiples AZ
vpc_cidr_block           = "10.2.0.0/16"
public_subnet_cidr_1    = "10.2.1.0/24"
public_subnet_cidr_2    = "10.2.2.0/24"
public_subnet_cidr_3    = "10.2.3.0/24"
private_subnet_cidr_1   = "10.2.10.0/24"
private_subnet_cidr_2   = "10.2.11.0/24"
private_subnet_cidr_3   = "10.2.12.0/24"
availability_zones      = ["us-east-1a", "us-east-1b", "us-east-1c"]

# Configuración de EC2 para producción - alta disponibilidad
instance_type           = "t3.medium"
instance_ami            = "ami-0c55b159cbfafe1f0"
instance_volume_size    = 50
instance_volume_type    = "gp3"
environment             = "production"

# Configuración de S3 para producción - máxima redundancia
s3_bucket_name          = "prod-infra-storage-assets"
s3_enable_versioning   = true
s3_enable_encryption    = true
s3_lifecycle_days       = 90
s3_replication_enabled  = true
s3_access_logging       = true

# Configuración de CloudWatch para producción - monitoreo completo
enable_detailed_monitoring = true
log_retention_days         = 30
alarm_email                = "devops-prod@empresa.com"
cpu_threshold_alarm        = 70
memory_threshold_alarm     = 75
disk_threshold_alarm       = 80
network_in_threshold       = 100000000
network_out_threshold      = 50000000

# Etiquetas para optimización de costos y gobierno
tags = {
  Environment = "production"
  Project     = "infra-gestion"
  CostCenter  = "prod-operations"
  ManagedBy   = "terraform"
  Owner       = "cloud-team"
  Compliance  = "HIPAA-ready"
  Backup      = "required"
  Criticality = "high"
}

# Configuración de alta disponibilidad para producción
enable_multi_az           = true
create_nat_gateway        = true
single_az_instance        = false
enable_flow_logs          = true
enable_vpn_connection     = true

# Configuración de recuperación ante desastres
enable_deletion_protection = true
backup_retention_days      = 30
rto_minutes               = 30
rpo_minutes               = 15

# Configuración de seguridad avanzada
enable_security_groups    = true
enable_nacls              = true
enable_dhcp_options       = true
enable_vpc_endpoints      = true

# Límites y cuotas específicas del ambiente
max_instance_count        = 10
autoscale_min             = 2
autoscale_max             = 8


// === ARCHIVO: scripts/create_instance.sh ===
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

// === ARCHIVO: scripts/delete_instance.sh ===
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

```
