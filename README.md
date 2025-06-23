# Proyecto Final AWS

## Instrucciones de Configuración
1. Clona este repositorio y los sub-repositorios (S3, Lambda, EC2).
2. Configura las credenciales de AWS como secretos de GitHub (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`).
3. Sube cambios a la rama `main` para activar los despliegues.
4. Accede a la aplicación web mediante la IP pública de EC2 (salida de Terraform).
5. Sube un CSV al bucket de entrada para generar reportes.

## Arquitectura
- **S3**: Almacena CSVs de entrada y reportes de salida.
- **Lambda**: Procesa CSVs y genera reportes.
- **EC2**: Aloja una aplicación web para ver reportes.
- **DynamoDB**: Registra el historial de ejecución.
- **Terraform**: Gestiona la infraestructura.
- **GitHub Actions**: Automatiza los despliegues.