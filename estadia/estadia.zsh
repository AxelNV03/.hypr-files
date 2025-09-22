#!/bin/zsh

alias serve='php artisan serve & npm run dev'

# Pull
# Actualiza la rama actual con los últimos cambios de 'dev' usando rebase.
# Uso (solo actualizar): gupdate
# Uso (commit, push y actualizar): gupdate "mensaje de commit"
gpull() {
     # --- VALIDACIONES INICIALES ---
          if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
               echo "❌ Error: No estás en un repositorio de Git."
               return 1
          fi
     
     local current_branch=$(git rev-parse --abbrev-ref HEAD)
     local commit_message="$1"
     
     if [ "$current_branch" = "dev" ]; then
          echo "🛑 ¡Alto! No puedes actualizar la rama 'dev' sobre sí misma."
          return 1
     fi
     
     if ! git diff --quiet; then
          echo "🛑 ¡Alto! Tienes cambios sin guardar en este proyecto."
          echo "   Haz commit o descarta los cambios antes de continuar."
          return 1
     fi
     
     # --- PASO 1: COMMIT Y PUSH OPCIONAL (REUTILIZANDO GPUSH) ---
     if [ -n "$commit_message" ]; then
          echo "💬 Mensaje detectado. Haciendo commit y push en '$current_branch' primero..."
          if ! gpush "$commit_message"; then
          echo "❌ Error durante el push inicial. Proceso cancelado."
          return 1
          fi
     fi
     
     # --- PASO 2: SECUENCIA DE ACTUALIZACIÓN CON REBASE ---
     echo "📥 Obteniendo los últimos cambios de 'dev' desde origin..."
     git fetch origin dev
     
     echo "🔄 Rebasando tu rama ('$current_branch') sobre 'origin/dev'..."
     git rebase origin/dev
     if [ $? -ne 0 ]; then
          echo "🛑 ¡Conflicto de rebase detectado!"
          echo "   Por favor, resuelve los conflictos y luego ejecuta 'git rebase --continue'."
          echo "   Cuando termines, deberás hacer push usando la opción '--force-with-lease'."
          return 1
     fi
     
     # --- PASO 3: PUSH FORZADO (SEGURO) DESPUÉS DEL REBASE ---
     echo "🚀 Reescribiendo el historial en el remoto para coincidir con el rebase..."
     git push --force-with-lease origin "$current_branch"
     
     echo "✅ ¡Proceso completado! Tu rama '$current_branch' está actualizada con 'dev'."
}


# Función para hacer pull en un proyecto Git específico
# Integra la rama actual en 'dev' para el proyecto en el que te encuentras.
# Uso (solo integrar): gcdev
# Uso (commit, push e integrar): gcdev "mensaje de commit"
gcdev() {
     # --- VALIDACIONES INICIALES ---
     if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
          echo "❌ Error: No estás en un repositorio de Git."
          return 1
     fi

     local source_branch=$(git rev-parse --abbrev-ref HEAD)
     local commit_message="$1"

     if [ "$source_branch" = "dev" ]; then
          echo "🛑 ¡Alto! Ya estás en la rama 'dev'. No puedes integrar 'dev' en sí misma."
          return 1
     fi

     echo "🚙 Iniciando proceso para integrar '$source_branch' en 'dev'..."
     if ! git diff --quiet; then
          echo "🛑 ¡Alto! Tienes cambios sin guardar en este proyecto."
          echo "   Haz commit o descarta los cambios antes de continuar."
          return 1
     fi

     # --- PASO 1: COMMIT Y PUSH OPCIONAL (REUTILIZANDO GPUSH) ---
     if [ -n "$commit_message" ]; then
          echo "💬 Mensaje detectado. Haciendo commit y push en '$source_branch' primero..."
          # Como ambas funciones son flexibles, ahora podemos llamar a gpush directamente.
          if ! gpush "$commit_message"; then
          echo "❌ Error durante el push de la rama $source_branch. Proceso cancelado."
          return 1
          fi
     fi

     # --- PASO 2: SECUENCIA DE INTEGRACIÓN ---
     echo "🔄 Cambiando a la rama 'dev' y actualizando..."
     git switch dev
     git pull origin dev
     git fetch origin # Asegura que tenemos las últimas referencias

     echo "🔗 Fusionando (merge) '$source_branch' en 'dev'..."
     git merge origin/"$source_branch"
     if [ $? -ne 0 ]; then
          echo "🛑 ¡Conflicto de merge detectado!"
          echo "   Por favor, resuelve los conflictos en este directorio y haz el push a 'dev' manualmente."
          return 1
     fi

     echo "🚀 Subiendo la rama 'dev' actualizada..."
     git push origin dev

     echo "↩️ Regresando a tu rama de origen ('$source_branch')..."
     git switch "$source_branch"

     echo "✅ ¡Proceso completado! La rama '$source_branch' fue integrada en 'dev'."
}


# Restablece base en protecmor
dbreset(){
     mysql -u nava -p1234 < ~/escuela/estadia/protecmor_BD_REPRESENTACION_FINAL.sql
     echo "Script de protecmor ejecutado."
     php artisan migrate
     echo "Migraciones ejecutadas."
     php artisan db:seed --class=RoleSeeder
     php artisan db:seed --class=UserSeeder
     echo "Seeders base ejecutados."
}
#---------------------------------------------------------------------------
# Función seed
# Función principal para listar y ejecutar seeders
seed() {
     # Inicializamos el arreglo de seeders
     seeders=()

     # Usamos un glob pattern de zsh para obtener solo los archivos .php en la carpeta seeders
     for file in database/seeders/*.php; do
          # Eliminar la ruta y la extensión .php
          seeder="${file##*/}"       # Obtiene solo el nombre del archivo
          seeder="${seeder%.php}"     # Elimina la extensión .php
          # Agregar el nombre al arreglo
          seeders+=("$seeder")
     done

    # Mostrar las opciones al usuario
    echo "Seeders disponibles:"
    echo "1. Todos"
    index=2  # Iniciar el índice desde 2 (ya que 1 es para "Todos")
    for seeder in "${seeders[@]}"; do
        echo "$index. $seeder"
        index=$((index + 1))  # Incrementar el índice
    done

    # Solicitar la selección del usuario
    echo -n "Selecciona una opción (o 'q' para cancelar): "
    read REPLY

    # Si el usuario elige "q" o "Q", cancelar la operación
    if [[ "$REPLY" =~ ^[Qq]$ ]]; then
        echo "Operación cancelada."
        return
    fi

    # Verificamos si el usuario eligió "1" para ejecutar todos los seeders
    if [[ "$REPLY" -eq 1 ]]; then
        echo "Ejecutando todos los seeders..."
        php artisan db:seed
        echo "Todos los seeders han sido ejecutados."
    elif [[ "$REPLY" -ge 2 && "$REPLY" -lt $(($index)) ]]; then
        # Si el número es válido, ejecutamos el seeder correspondiente
        seeder="${seeders[$REPLY-1]}"
        echo "Ejecutando el seeder: $seeder"

        # Ejecutar el seeder sin la extensión .php
        php artisan db:seed --class="$seeder"
        echo "Seeder $seeder ejecutado."
    else
        echo "Opción inválida. Intenta de nuevo."
    fi
}


# Funcion para ejecutar make
make() {
    # Mostrar las opciones disponibles
    echo "Opciones disponibles para crear:"
    echo "1. Seeder"
    echo "2. Migration"
    echo "3. Controller"
    echo "4. Model"
    echo "5. Factory"
#     echo "6. Middleware"
#     echo "7. Request"
#     echo "8. Test"
    echo "Selecciona una opción (o 'q' para cancelar): "
    
    # Leer la opción seleccionada por el usuario
    read REPLY

    # Si el usuario elige "q" o "Q", cancelar la operación
    if [[ "$REPLY" =~ ^[Qq]$ ]]; then
        echo "Operación cancelada."
        return
    fi

    # Definir el comando de 'make' según la opción elegida
    case $REPLY in
        1) 
            command="php artisan make:seeder"
            option="seeder"
            ;;
        2) 
            command="php artisan make:migration"
            option="migration"
            ;;
        3) 
            command="php artisan make:controller"
            option="controller --resource"
            ;;
        4) 
            command="php artisan make:model"
            option="model"
            ;;
        5) 
            command="php artisan make:factory"
            option="factory"
            ;;
        6) 
            command="php artisan make:middleware"
            option="middleware"
            ;;
        7) 
            command="php artisan make:request"
            option="request"
            ;;
        8) 
            command="php artisan make:test"
            option="test"
            ;;
        *)
            echo "Opción inválida. Intenta de nuevo."
            return
            ;;
    esac

    # Solicitar el nombre del recurso
    while true; do
        echo -n "Introduce el nombre del $option (o 'q/Q' para cancelar): "
        read name

        # Si el nombre contiene 'q' o 'Q', cancelar la operación
        if [[ "$name" =~ ^[Qq]$ ]]; then
            echo "Operación cancelada."
            return
        fi

        # Verificar si el nombre es válido (no vacío)
        if [[ -z "$name" ]]; then
            echo "El nombre no puede estar vacío. Intenta de nuevo."
        else
            # Ejecutar el comando correspondiente
            echo "Creando $option: $name..."
            $command "$name"
            echo "$option '$name' creado exitosamente."
            break
        fi
    done
}