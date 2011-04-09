#!/bin/bash
# Algunas variables utiles {{{ 
dirLocal=$PWD
dirPadre=${PWD%/*}
# }}}
#{{{ ln -s a los archivos de configuracion 
## agregar algunos ifs para relinkear cuando sea necesario
## .bashrc bin .config .dircolors .git .gitconfig .gitignore .hgrc README .screenrc .vim .vimrc .Xresources 
archivosRc=( .vim .vimrc .gitconfig .hgrc .screenrc .Xresources .dircolors .bashrc .ctags)
for a in ${archivosRc[@]}
do
	if [ -e $HOME/$a ]
	then 
		echo "$HOME/$a ya existe!"
	else
		if [ -e $a ]
		then
		ln -s $dirLocal/$a $HOME
		echo "ln -s $a $HOME"
		echo "Linkeado el directorio $a al $HOME"
		fi 
	fi
done
# }}}
# Clonado de plugins de vim {{{
## pensar si es las conveniente agregar archivos al gitignore y solo sean ubicados a traves de este script
# http://github.com/msanders/snipmate.vim.git
# http://github.com/ervandew/supertab.git
cd .vim
dirs=(after autoload ftplugin syntax)
for d in ${dirs[@]}
do 
	if [ ! -d $d ]
	then 
		mkdir $dirLocal/.vim/$d 
		echo "mkdir $dirLocal/.vim/$d"
		echo "Directorio $dirLocal/.vim/$d creado"
	fi
done
echo "Creando directorios necesarios para vim"
cd $dirLocal
repos=( msanders/snipmate.vim.git ervandew/supertab.git vim-scripts/python_fold.git vim-scripts/xoria256.vim.git vim-scripts/mayansmoke.git pixelmuerto/vim-pixelmuerto.git hallison/vim-markdown.git fholgado/minibufexpl.vim.git Shougo/vimshell.git Shougo/vimproc.git scrooloose/nerdtree.git )
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
		git clone $r >& /dev/null
		echo 
		echo "Clonado $r"
		cd rc
	fi
	if [ -d ../$repoDirName ]
	then 
		echo 
		echo "cd $dirPadre/$repoDirName"
		cd ../$repoDirName
		git pull
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
					relink=$(ls -l $pContentToMove | awk '{print $(NF-2),$(NF-1),$NF}')
					echo "relinkeado $relink"
				else
					if [ -h $pContentToMove ] 
					then 
						unlink $pContentToMove 	
						ln -s $PWD/$pContent $pContentToMove 
						relink=$(ls -l $pContentToMove | awk '{print $(NF-2),$(NF-1),$NF}')
						echo "relinkeado $relink"
					else
						for c in $(ls $pContent)
						do
							if [[ -e $pContentToMove/$c || -h $pContentToMove/$c ]]
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
								relink=$(ls -l $pContentToMove/$c | awk '{print $(NF-2),$(NF-1),$NF}')
								echo "relinkeado $relink"
							fi
						done
					fi
				fi
			fi
		done
		cd $dirLocal 
		echo
		echo "cd $dirLocal"
	else 
		echo "No se clono correctamente $r"
	fi
done
# }}}
# bash completions {{{
mkdir .bash_completion.d
echo "mkdir .bash_completion.d"
echo "Directorio $dirLocal/.bash_completion.d creado"
if [ ! -d $HOME/.bash_completion.d ]
then 
	ln -s $dirLocal/.bash_completion.d $HOME
	relink=$(ls -l $HOME/.bash_completion.d | awk '{print $(NF-2),$(NF-1),$NF}')
	echo "relinkeado $relink"
fi 
cd .bash_completion.d 
echo "cd .bash_completion.d"
echo "Descargando git-completion"
echo "wget -c http://repo.or.cz/w/git.git/blob_plain/HEAD:/contrib/completion/git-completion.bash"
wget -c http://repo.or.cz/w/git.git/blob_plain/HEAD:/contrib/completion/git-completion.bash
cd $dirLocal 
echo "cd $dirLocal"
# }}}
