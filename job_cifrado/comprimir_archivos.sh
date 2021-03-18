#! bin/bash

path_job="/home/hadoop/Documentos/code/scripts-shell/job_cifrado"
path_encrypted="/home/hadoop/Documentos/code/scripts-shell/job_cifrado/encrypted"
path_destino="/home/hadoop/Documentos/code/scripts-shell/job_cifrado/destino"

cd $path_encrypted
ls -d * > $path_job/nombreCarpetas.out
echo "Se creo el archivo nombreCarpetas.out "

for folder in $(cat $path_job/nombreCarpetas.out);do
cd $path_encrypted/$folder
ls -d * > $path_job/nombreArchivos.out

for file in $(cat $path_job/nombreArchivos.out);do
echo $file
# Comprime cada archivo interno de cada carpeta padre
gzip -k $path_encrypted/$folder/$file

done

mkdir $path_destino/$folder
mv $path_encrypted/$folder/*.gz $path_destino/$folder

done
echo "El programa se ejecuto satisfactoriamente"

# Por ultimo escribir una linea para eliminar el contenido de la carpeta
# rm -r $path_encrypted/*





