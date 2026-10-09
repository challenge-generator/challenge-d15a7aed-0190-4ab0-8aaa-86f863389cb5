# Gestión de infraestructura en la nube

El candidato administrará los servicios en la nube, comprendiendo el ecosistema de funcionamiento y desarrollando scripts básicos para la creación de infraestructura y las actividades operativas requeridas. Los servicios incluyen la creación y gestión de instancias de máquinas virtuales, configuración de redes virtuales, y el uso de servicios de almacenamiento. Los actores involucrados son el administrador de la nube, el sistema de monitoreo y el usuario final. Las propiedades operativas incluyen la latencia de las operaciones de creación de instancias (<5s) y la disponibilidad del servicio (>99.9%). El modo de falla específico es la pérdida de conectividad durante la configuración de la red.

## Informacion General

| Campo | Valor |
|-------|-------|
| **Tema** | Administración básica de infraestructura |
| **Nivel** | advanced-l1 |
| **Tipo** | practical |
| **Tiempo estimado** | 8 horas |

## Fases del Reto

### Fase 0: Configuración del Proyecto

**Objetivo:** Obtener el proyecto base funcional enviando el Código Base a un asistente de IA, que lo analizará, corregirá errores y generará un ZIP listo para usar.

**Tiempo estimado:** 15-30 minutos

**Instrucciones:**

- Asegúrate de tener instalado para ejecutar el proyecto: Un IDE o editor de código.
- Copia todo el contenido del campo **Código Base** de este reto — incluyendo el texto de instrucciones que aparece al inicio.
- Abre un asistente de IA (Claude en claude.ai, ChatGPT o Gemini — se recomienda Claude), pega el contenido copiado en el chat y envíalo.
- El asistente analizará los archivos, corregirá errores y generará un archivo ZIP descargable. Descárgalo y extráelo en la carpeta donde quieras trabajar.
- Verifica que el proyecto arranca sin errores.

**Entregable:** El proyecto compila/arranca sin errores.

<details>
<summary>Pistas de conocimiento</summary>

- Copia el Código Base completo incluyendo el texto de instrucciones al inicio — esas instrucciones le indican al asistente exactamente qué hacer con los archivos.
- Si el asistente no genera el ZIP automáticamente al terminar el análisis, escríbele: "genera el ZIP ahora".
- Si el proyecto tiene errores al arrancar, comparte el mensaje de error con el mismo asistente para que lo corrija.

</details>

### Fase 1: Configuración inicial de la infraestructura

**Objetivo:** Establecer una infraestructura básica en la nube que incluya una red virtual, una instancia de máquina virtual y un servicio de almacenamiento.

**Tiempo estimado:** 2 horas

**Instrucciones:**

- Identificar los servicios de la nube necesarios para la creación de la infraestructura.
- Configurar una red virtual con subredes y reglas de seguridad.
- Provisionar una instancia de máquina virtual y asegurar su conectividad a la red.
- Configurar un servicio de almacenamiento y asegurar su accesibilidad desde la instancia de máquina virtual.

**Entregable:** Documentación de la configuración inicial de la infraestructura en la nube.

<details>
<summary>Pistas de conocimiento</summary>

- Considera las mejores prácticas para la seguridad y el rendimiento al configurar la red virtual.
- Reflexiona sobre la elección del tipo de instancia de máquina virtual en función de los requisitos de la aplicación.

</details>

### Fase 2: Desarrollo de scripts de administración

**Objetivo:** Crear scripts básicos para la gestión de la infraestructura creada, incluyendo la creación y eliminación de recursos.

**Tiempo estimado:** 3 horas

**Instrucciones:**

- Desarrollar un script para la creación de una nueva instancia de máquina virtual.
- Desarrollar un script para la eliminación de una instancia de máquina virtual existente.
- Asegurar que los scripts incluyan manejo de errores y verificación de la existencia de recursos antes de la creación o eliminación.

**Entregable:** Scripts de administración de la infraestructura en la nube.

<details>
<summary>Pistas de conocimiento</summary>

- Considera la inclusión de comentarios y documentación dentro de los scripts para mejorar la mantenibilidad.
- Reflexiona sobre la elección de los lenguajes de scripting y las herramientas de la nube para la automatización.

</details>

### Fase 3: Monitoreo y optimización

**Objetivo:** Implementar un sistema de monitoreo para la infraestructura y realizar optimizaciones basadas en los datos recolectados.

**Tiempo estimado:** 3 horas

**Instrucciones:**

- Configurar un sistema de monitoreo para la infraestructura creada.
- Recolectar datos de rendimiento y utilización de recursos.
- Analizar los datos recolectados e identificar áreas de optimización.
- Implementar cambios en la configuración de la infraestructura para mejorar el rendimiento y la eficiencia.

**Entregable:** Informe de monitoreo y optimización de la infraestructura en la nube.

<details>
<summary>Pistas de conocimiento</summary>

- Considera la utilización de servicios de monitoreo nativos de la nube para la recolección de datos.
- Reflexiona sobre las métricas más relevantes para el rendimiento y la eficiencia de la infraestructura.

</details>

## Dimensiones Evaluadas

- **queEs**: ¿Qué es la infraestructura en la nube y cuáles son sus componentes principales?
- **paraQueSirve**: ¿Para qué sirve la gestión de la infraestructura en la nube y cuáles son sus beneficios?
- **comoSeUsa**: ¿Cómo se usan los scripts de administración para la gestión de la infraestructura en la nube?
- **erroresComunes**: ¿Cuáles son los errores comunes al desarrollar scripts de administración y cómo se pueden evitar?
- **queDecisionesImplica**: ¿Qué decisiones implica la implementación de un sistema de monitoreo y optimización de la infraestructura en la nube?

## Criterios de Evaluacion

- Configuración inicial de la infraestructura en la nube.
- Desarrollo de scripts de administración.
- Implementación de un sistema de monitoreo y optimización.

## Como trabajar con un asistente de IA

Hay dos caminos, elegi uno:

- **AGENTS.md** (recomendado) — instrucciones nativas del repo. Abri esta carpeta con tu agente local (Claude Code, Cursor, Codex, Copilot, Gemini) y las carga solo. Sabe que archivos faltan y con que comando se verifica, y completa el scaffold escribiendo en disco.
- **PROMPT_MEJORA.md** — para copiar y pegar en un chat (claude.ai, ChatGPT). Devuelve un ZIP con el proyecto. Sirve si no tenes un agente en el IDE.

Ninguno de los dos resuelve las fases del reto: eso es tu trabajo.

## Verificacion

El proyecto esta listo para trabajar cuando este comando corre sin errores:

```bash
terraform init -backend=false && terraform validate && terraform fmt -check
```

---

*Reto generado automaticamente por Challenge Generator - Pragma*
