#!/bin/bash -vx

# Crear un archivo de texto plano llamado mytext con la cadena “Hola Mundo”
echo "Hola Mundo" > mytext
# Imprimir en la terminal el contenido del archivo mytext
cat mytext
# Crear una carpeta llamada backup
mkdir backup
# Mover el archivo mytext a la careta backup
mv mytext backup/
# Listar el contenido de la carpeta backup
ls backup/
# Eliminar el archivo mytext del fichero backup
rm backup/mytext
# Eliminar el fichero backup
rmdir backup