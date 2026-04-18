# Changelog

Todos los cambios notables de este proyecto se documentan en este archivo.

El formato se basa en [Keep a Changelog](https://keepachangelog.com/es-ES/1.1.0/)
y este proyecto adhiere a [Versionado Semántico](https://semver.org/lang/es/).

## [1.4.0] - 2026-04-17

### Added
- Carpeta `tests/` con 3 planes JSON de prueba para las políticas OPA (PR #9).
- Carpeta `evidencias/` con salidas reales de las 6 pruebas ejecutadas en AWS.
- README dentro de `tests/` documentando los escenarios y cómo reproducirlos.

### Changed
- CHANGELOG actualizado para reflejar el nuevo contenido de documentación.

## [1.3.1] - 2026-04-17

### Fixed
- Políticas OPA migradas de sintaxis Rego v0 a Rego v1 (PR #8).
- Workflow de GitHub Actions con `skip_check` para excluir checks de Checkov fuera del scope del parcial.

## [1.3.0] - 2026-04-17

### Added
- Políticas de seguridad en Rego para Open Policy Agent (OPA) (PR #4).
- Política que deniega Security Groups con SSH abierto a `0.0.0.0/0`.
- Política que restringe el tipo de instancia EC2 exclusivamente a `t2.micro`.
- Integración de OPA en el pipeline de GitHub Actions como etapa de validación de conformidad.

## [1.2.0] - 2026-04-17

### Added
- Pipeline de CI/CD en GitHub Actions (PR #3).
- Etapa de análisis estático con TFLint.
- Etapa de análisis de seguridad con Checkov.
- Etapa de validación con `terraform validate`.
- Trigger configurado para activarse solo en Pull Requests hacia `main`.

## [1.1.0] - 2026-04-17

### Added
- Definición de infraestructura base en AWS (PR #2).
- VPC con CIDR `10.1.0.0/16`.
- Subred pública con CIDR `10.1.1.0/24`.
- Security Group con ingreso SSH restringido al bloque de la VPC.
- Instancia EC2 `t2.micro` con AMI Ubuntu 24.04 LTS.

### Changed
- Actualizado el provider de AWS a `~> 6.0` (última versión mayor disponible).

## [1.0.0] - 2026-04-17

### Added
- Creación inicial del repositorio (PR #1).
- Archivo `README.md` con descripción del proyecto, arquitectura y uso.
- Archivo `.gitignore` configurado para excluir archivos sensibles y directorios de Terraform.
- Archivo `CHANGELOG.md` para registrar la evolución del proyecto.
