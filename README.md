cat << 'EOF' > README.md
# AUY1105 - Infraestructura como Código II
## Evaluación Parcial 1: Automatización de Análisis de Calidad y Seguridad

Este repositorio contiene la implementación de una arquitectura en la nube mediante **Terraform**, integrada en un pipeline de **CI/CD** con validaciones automáticas de seguridad y cumplimiento normativo.

---

## 📑 Tabla de Contenidos
1. [Propósito del Proyecto](#propósito-del-proyecto)
2. [Arquitectura de Infraestructura](#arquitectura-de-infraestructura)
3. [Pipeline de CI/CD](#pipeline-de-cicd)
4. [Políticas de Seguridad (OPA)](#políticas-de-seguridad-opa)
5. [Estructura del Proyecto](#estructura-del-proyecto)
6. [Autores](#autores)

---

## 🎯 Propósito del Proyecto
El objetivo principal es desplegar una infraestructura base en **AWS** siguiendo el paradigma de **GitOps**. Se prioriza la seguridad mediante el análisis estático de código y la aplicación de políticas como código antes de cualquier despliegue en el entorno de producción (`main`).

---

## 🏗️ Arquitectura de Infraestructura
La infraestructura se despliega en la región `us-east-1` y comprende los siguientes recursos bajo una nomenclatura estandarizada (`AUY1105-proyecto1-*`):

| Recurso | Configuración | Propósito |
| :--- | :--- | :--- |
| **VPC** | CIDR `10.1.0.0/16` | Aislamiento de red para el proyecto. |
| **Subnet** | CIDR `10.1.1.0/24` | Segmento de red público para cómputo. |
| **Security Group** | Puerto 22 (TCP) | Control de acceso perimetral restringido. |
| **EC2 Instance** | `t2.micro` (Ubuntu 24.04 LTS) | Servidor de aplicaciones base. |

---

## ⚙️ Pipeline de CI/CD
Se utiliza **GitHub Actions** para automatizar el ciclo de vida del código. El flujo se dispara en cada *Pull Request* hacia la rama `main` y consta de las siguientes etapas:

1. **Terraform Validate:** Verifica la sintaxis y coherencia interna de los archivos de configuración.
2. **Análisis Estático (TFLint):** Valida mejores prácticas de AWS y detecta errores comunes que el compilador básico no identifica.
3. **Análisis de Seguridad (Checkov):** Escanea la infraestructura en busca de vulnerabilidades y configuraciones inseguras (misconfigurations).

---

## 🛡️ Políticas de Seguridad (OPA)
Para garantizar el cumplimiento normativo, se han implementado políticas mediante **Open Policy Agent** en lenguaje **Rego**:

* **Restricción SSH:** Bloquea cualquier intento de abrir el puerto 22 a todo el tráfico de internet (`0.0.0.0/0`).
* **Control de Tipos de Instancia:** Limita el uso exclusivo de instancias `t2.micro` para prevenir sobrecostos accidentales.

---

## 📂 Estructura del Proyecto
.
├── .github/workflows/    # Definición del Pipeline CI/CD (YAML)
├── policies/             # Políticas de cumplimiento (Rego/OPA)
├── .gitignore            # Exclusión de binarios y secretos de Terraform
├── CHANGELOG.md          # Registro histórico de versiones y cambios
├── main.tf               # Definición de recursos en AWS
└── README.md             # Documentación técnica principal

---

## 👥 Autores
* **Carlos Rodrigo Cuevas Núñez** - Estudiante de Ingeniería en Infraestructura Tecnológica
* **Daniel** - Estudiante de Ingeniería en Infraestructura Tecnológica

---
© 2026 - Duoc UC - Facultad de Ingeniería y Recursos Naturales.
