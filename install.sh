#!/bin/bash
dirLocal=$PWD
dirPadre=${PWD%/*}
echo "Ubicacion actual $dirLocal"
archivosRc=( .vim .vimrc )
for a in ${archivosRc[@]}
do
	if [ -e $HOME/$a ]
	then 
		echo "$HOME/$a ya existe!"
	else
		if [ -e $a ]
		then
		ln -s $a $HOME
		echo "ln -s $a $HOME"
		echo "Linkeado el directorio $a al $HOME"
		fi 
	fi
done
# !! agregar git clone, unlink y ln -s para los plugins de vim. ver README en el directorio .vim 
# 
#http://github.com/msanders/snipmate.vim.git
#http://github.com/ervandew/supertab.git
repos=( msanders/snipmate.vim.git ervandew/supertab.git )
for repo in ${repos[@]}
do
	#echo "http://github.com/$repo"
	repoDirName=${repo#*/}
	repoDirName=${repoDirName%.*}
	if [ ! -d ../$repoDirName ]
	then 
		echo "Clonando $repoDirName"
		r=http://github.com/$repo
		cd ..
		git clone $r
		echo 
		echo "Clonado $r"
		cd rc
	fi
	if [ -d ../$repoDirName ]
	then 
		echo 
		echo "cd $dirPadre/$repoDirName"
		cd ../$repoDirName
		vimDir="$HOME/.vim"
		vimDirContent=$(find $vimDir -maxdepth 1 -type d )
		pluginContent=$(find . -maxdepth 1 -type d )
		for pContent in $pluginContent
		do 
			pContent=${pContent#*/}
			if [[ "$pContent" != ".git" && "$pContent" != "." ]]
			then
				pContentToMove=$vimDir/$pContent
				if [ ! -d $pContentToMove ] 
				then 
					echo "No existe $pContentToMove"
					mkdir $pContentToMove
					echo "mkdir $pContentToMove"
					echo "Directorio $pContentToMove creado"
				fi
			ln -s $PWD/$pContent/* $pContentToMove
			fi
		done
		cd $dirLocal 
		echo "cd $dirLocal"
	else 
		echo "No se clono correctamente $r"
	fi
done
