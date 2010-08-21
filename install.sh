#!/bin/bash
if [ -d $HOME/.vim ]
then 
	echo "El directorio $HOME/.vim ya existe!"
else
	if [ -d .vim ]
	then
	ln -s .vim $HOME
	echo "ln -s .vim $HOME"
	echo "Linkeado el directorio .vim al $HOME"
	fi 
fi
if [ -f $HOME/.vimrc ]
then 
	echo "El archivo $HOME/.vimrc ya existe!"
else
	if [ -f .vimrc ]
	then
	ln -s .vimrc $HOME
	echo "ln -s .vimrc $HOME"
	echo "Linkeado el archivo .vimrc al $HOME"
	fi 
fi
