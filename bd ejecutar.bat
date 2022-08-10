echo Instalador de la base de datos Universidad
echo Autor: Matheusz
echo 8 de 8 de 2012
sqlcmd -S. -E -i BDUniversidad.sql
sqlcmd -S. -E -i BDUniversidadPA-A.sql
sqlcmd -S. -E -i BDUniversidadPA-E.sql
echo Se ejecuto correctamente la base de datos
pause