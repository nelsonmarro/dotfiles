#!/bin/bash

# Archivo de configuración con rutas de proyectos
CONFIG_FILE="$HOME/dotfiles/scripts/auto-commit-projects.conf"

# Verificar que el archivo de configuración exista
if [ ! -f "$CONFIG_FILE" ]; then
  echo "Error: No se encuentra el archivo de configuración: $CONFIG_FILE"
  exit 1
fi

# Leer cada línea del archivo de configuración
while IFS= read -r line || [ -n "$line" ]; do
  # Ignorar líneas vacías o comentarios
  [[ "$line" =~ ^#.*$ || -z "$line" ]] && continue

  # Separar ruta del repositorio y mensaje de commit
  REPO_DIR=$(echo "$line" | cut -d' ' -f1)
  COMMIT_MESSAGE=$(echo "$line" | cut -d' ' -f2-)

  # Usar valores predeterminados si faltan
  COMMIT_MESSAGE="${COMMIT_MESSAGE:-Commit automático: $(date +'%Y-%m-%d %H:%M:%S')}"

  # Ejecutar el commit y push para cada proyecto
  if [ -d "$REPO_DIR/.git" ]; then
    cd "$REPO_DIR" || continue
    git add .
    git commit -m "$COMMIT_MESSAGE"
    git push origin main
  else
    echo "Error: $REPO_DIR no es un repositorio Git válido."
  fi
done <"$CONFIG_FILE"
