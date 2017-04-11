#!/bin/zsh

if [ ! -f $repj ];then
	exit
fi
if [ `cat $repj| jq 'length'` -eq 0 ] || ! cat $repj| jq . > /dev/null 2>&1 || [ -z "`cat $repj |jq -r "keys|.[]"` " ];then
	exit
fi

dd=`cat $repj| jq -r '.[].dir'`
if [ "$2" = "afp" ];then
	dd=`echo "$dd"|peco`
	n=`echo "$dd"|wc -l`
else
	n=`echo "$dd"|wc -l`
fi
for ((i=1; i<=$n; i++ )) do
        f=`echo "$dd"|awk "NR==$i"`
	case $2 in
		afp)
			echo $f
			zsh -c "cd $f
			git fetch origin
			git reset --hard origin/master
			git pull"
		;;
		af)
			echo $f
			zsh -c "cd $f
			git fetch origin
			git reset --hard origin/master
			git pull"
		;;
		a)
			echo $f
			cd $f
			git pull
		;;
		f)
			if [ $i -eq 1 ] && git status > /dev/null 2>&1;then
				git fetch origin
				git reset --hard origin/master
				git pull
			fi
		;;
		h)
			cat ${0:a}
		;;
		"")
			if [ $i -eq 1 ] && git status > /dev/null 2>&1;then
				git pull
			fi
		;;
	esac
done

