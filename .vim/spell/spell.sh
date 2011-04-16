#!/bin/bash
## para descargar diccionario de ortografia
cd $HOME/.vim/spell
leng="es"
lenguaje=$leng".utf-8"
l0=$lenguaje".sug"
if [ ! -e $l0 ]
then
	echo
	echo "Descargando $l0"
	echo
	wget -c http://ftp.vim.org/pub/vim/runtime/spell/$l0
else 
	echo
	echo "Ya existe $l0"
	echo
fi 
l1=$lenguaje".spl"
if [ ! -e $l1 ]
then
	echo
	echo "Descargando $l1"
	echo
	wget -c http://ftp.vim.org/pub/vim/runtime/spell/$l1
else
	echo
	echo "Ya existe $l1"
	echo
fi 
#wget -c http://ftp.vim.org/pub/vim/runtime/spell/es.utf-8.sug
#wget -c http://ftp.vim.org/pub/vim/runtime/spell/es.utf-8.spl
