#!/bin/bash
# Algunas variables utiles {{{ 
dirLocal=$PWD
dirPadre=${PWD%/*}
# }}}
#{{{ ln -s a los archivos de configuracion 
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
# }}}
# Clonado de plugins de vim {{{
# http://github.com/msanders/snipmate.vim.git
# http://github.com/ervandew/supertab.git
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
				if [ ! -e $pContentToMove ] 
				then 
					ln -s $PWD/$pContent $vimDir
				else
					if [ -h $pContentToMove ] 
					then 
						unlink $pContentToMove 	
						ln -s $PWD/$pContent $pContentToMove 
						relink=$(ls -s $pContentToMove | awk '{print $(NF-2),$(NF-1),$NF}')
						echo "relinkeado $relink"
					else
						#ln -s $PWD/$pContent/* $pContentToMove
						for c in $(ls $pContent)
						do
							if [[ -e $pContentToMove/$c ]]
							then
								if [[ -h $pContentToMove/$c  ]]
								then 
									unlink $pContentToMove/$c
									ln -s $PWD/$pContent/$c $pContentToMove/$c 
									relink=$(ls -l $pContentToMove/$c | awk '{print $(NF-2),$(NF-1),$NF}')
									echo "relinkeado $relink"
								else
									echo "$pContentToMove/$c ya existe!"
								fi 
							else
								ln -s $PWD/$pContent/$c $pContentToMove/$c 
							fi
						done
					fi
				fi
			fi
		done
		cd $dirLocal 
		echo "cd $dirLocal"
	else 
		echo "No se clono correctamente $r"
	fi
done
# }}}
