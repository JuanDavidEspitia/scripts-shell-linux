#!/bin/bash
echo "Scrip de conciliacion con MD5Sum"

path_tierra="/home/hadoop/Documentos/code/scripts-shell/md5sum_validation/input/appTierra"
path_cloud="/home/hadoop/Documentos/code/scripts-shell/md5sum_validation/input/appCloud"
path_fail="/home/hadoop/Documentos/code/scripts-shell/md5sum_validation/input/appFail"
path_output="/home/hadoop/Documentos/code/scripts-shell/output"

# Borramos inicialmente el archivo de salida
echo "Se borrar inicialmente los archivos resultado en la carpeta de salida "
rm -rf $path_output/hashesTierra.txt
rm -rf $path_output/hashesCloud.txt
rm -rf $path_output/hashesFail.txt

# Leer archivo por archi y aplicar md5sum
# md5sum ./input/file1.txt ./input/file2.txt ./input/file3.txt > ./output/hashes.txt
# md5sum ./input/aplicaciones/* > ./output/hashes.txt

# Leer multiples archivos de varias carpetas recursivamente
# for i in **; do [[ -f "$i" ]] && md5sum "$i" >> ./output/hashes.txt; done
# find -type f -exec md5sum '{}' \; > /output/hashes.txt

# Hacemos md5sum sobre los archivos tierra
find $path_tierra/ -type f \( -not -name "hashesTierra.txt" \) -exec md5sum '{}' \; > $path_output/hashesTierra.txt

# Hacemos md5sum sobre la data cargada en cloud
find $path_cloud/ -type f \( -not -name "hashesCloud.txt" \) -exec md5sum '{}' \; > $path_output/hashesCloud.txt

# Hacemos md5sum sobre la data cargada en Fail
find $path_fail/ -type f \( -not -name "hashesFail.txt" \) -exec md5sum '{}' \; > $path_output/hashesFail.txt


echo "    ---- Se termino el proceso de conciliacion de todas las aplicaciones --> OK    "

# Realizamos un proceso de limpieza dentro del archivo de salida

# sed 's/.*\(aplicaciones\)/\1/g' '/home/hadoop/Documentos/code/scripts-shell/output/hashes.txt'
# ruta="/home/hadoop/Documentos/code/scripts-shell/input/aplicaciones/"
# sed "//home/hadoop/Documentos/code/scripts-shell/input/aplicaciones//d" '/home/hadoop/Documentos/code/scripts-shell/output/hashes.txt'
# ruta="/home/hadoop/Documentos/code/scripts-shell/input/aplicaciones/"
# sed -i '\|/home/hadoop/Documentos/code/scripts-shell/input/aplicaciones/|d' '/home/hadoop/Documentos/code/scripts-shell/output/hashes.txt'
# sed -i 's:'$ruta'//g' '/home/hadoop/Documentos/code/scripts-shell/output/hashes.txt'

# Realizamos un chequeo para conocer cuales archivos concuerdan
# echo "    ---- Realizamos un chequeo de los archivos ----"
# md5sum --check ./output/hashes.txt

# Detectar cambios en un archivo, El código de estado devuelve # 0 si no hay cambios y 1 si los archivos no coinciden
md5sum --status --check $path_output/hashes*.txt
Result=$?
echo "File check status is: $Result"

exit $Result

