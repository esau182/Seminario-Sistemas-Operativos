#!/bin/bash

while true; do
    echo "======================================"
    echo "        Menú de Servicios"
    echo "======================================"
    echo "1) Listar el contenido de un fichero (o carpeta)"
    echo "2) Crear un archivo de texto con una línea de texto"
    echo "3) Comparar dos archivos de texto"
    echo "4) Demostrar el uso del comando awk"
    echo "5) Demostrar el uso del comando grep"
    echo "6) Salir"
    echo "======================================"
    read -p "Seleccione una opción: " opcion

    case "$opcion" in
        1)
            # Opción 1: Listar contenido de un fichero o carpeta
            read -p "Ingrese la ruta absoluta del fichero o carpeta: " ruta
            if [ -e "$ruta" ]; then
                echo "Contenido de '$ruta':"
                ls -la "$ruta"
            else
                echo "La ruta '$ruta' no existe."
            fi
            ;;
        2)
            # Opción 2: Crear un archivo de texto con una línea de texto
            read -p "Ingrese la cadena de texto a almacenar: " cadena
            read -p "Ingrese el nombre del archivo a crear (ej. archivo.txt): " archivo
            echo "$cadena" > "$archivo"
            echo "El archivo '$archivo' ha sido creado con el siguiente contenido:"
            cat "$archivo"
            ;;
        3)
            # Opción 3: Comparar dos archivos de texto
            read -p "Ingrese la ruta del primer archivo: " archivo1
            read -p "Ingrese la ruta del segundo archivo: " archivo2
            if [ -e "$archivo1" ] && [ -e "$archivo2" ]; then
                echo "Comparando archivos..."
                # Ejecutar diff y redirigir la salida para evitar mostrarla si son iguales
                if diff "$archivo1" "$archivo2" >/dev/null; then
                    echo "Los archivos son iguales."
                else
                    echo "Los archivos son diferentes."
                    echo "Diferencias:"
                    diff "$archivo1" "$archivo2"
                fi
            else
                echo "Uno o ambos archivos no existen."
            fi
            ;;

        4)
            # Opción 4: Demostración del uso de awk
            echo "Demostración del comando awk:"
            echo "Ejemplo: convertir una cadena a mayúsculas"
            read -p "Ingrese una cadena de texto: " texto
            echo "Texto en mayúsculas:"
            echo "$texto" | awk '{print toupper($0)}'
            ;;
        5)
            # Opción 5: Demostración del uso de grep
            echo "Demostración del comando grep:"
            read -p "Ingrese el patrón a buscar: " patron
            read -p "Ingrese la ruta absoluta del archivo en el cual buscar: " file_grep
            if [ -e "$file_grep" ]; then
                echo "Resultados de grep para el patrón '$patron':"
                grep "$patron" "$file_grep"
            else
                echo "El archivo '$file_grep' no existe."
            fi
            ;;
        6)
            echo "Saliendo..."
            exit 0
            ;;
        *)
            echo "Opción no válida. Por favor, seleccione una opción del 1 al 6."
            ;;
    esac

    echo ""
    read -p "Presione Enter para continuar..."
    clear
done
