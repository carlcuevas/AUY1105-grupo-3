<div align="center">
  <img src="https://img.shields.io/badge/Terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white" alt="Terraform" />
  <img src="https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white" alt="AWS" />
  <img src="https://img.shields.io/badge/GitHub_Actions-%232671E5.svg?style=for-the-badge&logo=githubactions&logoColor=white" alt="GitHub Actions" />
  <img src="https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white" alt="Ubuntu" />
  <img src="https://img.shields.io/badge/OPA_Rego-000000?style=for-the-badge&logo=open-policy-agent&logoColor=white" alt="OPA Rego" />
</div>

# AUY1105 - Infraestructura como Código II
## Evaluación Parcial 1: Automatización de Análisis de Calidad y Seguridad

**Grupo 3** - Integrantes: 
* Carlos Rodrigo Cuevas Núñez
* Daniel Tapia Sobarzo

---

### 📑 Tabla de Contenidos
1. [Propósito del Proyecto](#-propósito-del-proyecto)
2. [Arquitectura de Infraestructura](#-arquitectura-de-infraestructura)
3. [Pipeline de CI/CD](#-pipeline-de-cicd)
4. [Políticas de Seguridad (OPA)](#-políticas-de-seguridad-opa)
5. [Evidencias de Revisión (Pull Requests)](#-evidencias-de-revisión)
6. [Estructura del Proyecto](#-estructura-del-proyecto)

---

### 🎯 Propósito del Proyecto
El objetivo principal es desplegar una infraestructura base en AWS siguiendo el paradigma de **GitOps**. Se prioriza la seguridad mediante el análisis estático de código y la aplicación de políticas como código (PaC) antes de realizar cualquier cambio en el entorno principal.

### 🏗️ Arquitectura de Infraestructura
La infraestructura se despliega en la región `us-east-1` utilizando los siguientes recursos bajo la nomenclatura `AUY1105-proyecto1-*`:

| Recurso | Configuración | Propósito |
| :--- | :--- | :--- |
| **VPC** | CIDR 10.1.0.0/16 | Aislamiento de red para el proyecto. |
| **Subnet** | CIDR 10.1.1.0/24 | Segmento de red público para cómputo. |
| **Security Group** | Puerto 22 (TCP) | Control de acceso perimetral restringido. |
| **EC2 Instance** | t2.micro (Ubuntu 24.04 LTS) | Servidor de aplicaciones base. |

> **Evidencia Técnica:**
> ![Captura de pantalla de main.tf o recursos creados]

---

### ⚙️ Pipeline de CI/CD
Se utiliza **GitHub Actions** para automatizar el ciclo de vida del código. El flujo se dispara en cada **Pull Request** hacia la rama `main`:

* **Terraform Validate:** Verifica la sintaxis y coherencia interna.
* **Análisis Estático (TFLint):** Valida mejores prácticas de AWS.
* **Análisis de Seguridad (Checkov):** Escanea en busca de vulnerabilidades y malas configuraciones.

> **Evidencia de Ejecución:**
> ![Captura de GitHub Actions con los checks en verde]

---

### 🛡️ Políticas de Seguridad (OPA)
Para garantizar el cumplimiento normativo (Compliance), hemos implementado políticas mediante **Open Policy Agent (OPA)** en lenguaje Rego:

1.  **Restricción SSH:** Bloquea cualquier intento de abrir el puerto 22 a todo el tráfico de internet (`0.0.0.0/0`).
2.  **Control de Tipos de Instancia:** Limita el uso exclusivo de instancias `t2.micro`.

> **Evidencia de Cumplimiento:**
> ![Captura de log de OPA aprobando o rechazando un cambio]

---

### 🤝 Evidencias de Revisión (Pull Requests)
Siguiendo los requerimientos de la rúbrica (IL 1.1), el trabajo se gestionó mediante revisiones cruzadas:

* **PR #1:** Configuración de Repositorio (Daniel) - Revisado por Carlos.
* **PR #2:** Implementación de Infraestructura (Carlos) - Revisado por Daniel.
* **PR #3:** Pipeline de CI/CD (Daniel) - Revisado por Carlos.
* **PR #4:** Políticas OPA y Docs (Carlos) - Revisado por Daniel.

> **Evidencia de Colaboración:**
> ![Captura de la sección Pull Requests donde se vean comentarios de revisión]

---

### 📂 Estructura del Proyecto
```text
.
├── .github/workflows/   # Definición del Pipeline CI/CD (YAML)
├── policies/            # Políticas de cumplimiento (Rego/OPA)
├── .gitignore           # Exclusión de binarios y secretos
├── CHANGELOG.md         # Registro histórico de versiones y cambios
├── main.tf              # Definición de recursos en AWS
└── README.md            # Documentación técnica principal

<img width="1026" height="641" alt="imagen" src="https://github.com/user-attachments/assets/ab766a2d-aa10-4c53-916e-3edfac9993bb" />
