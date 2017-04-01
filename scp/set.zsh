#!/bin/zsh

if cat $conj | jq -r '.dir' > /dev/null 2>&1 && [ -n "`cat $conj | jq -r 'keys|.[]'`" ] ;then
	cat $repj | jq .
	echo "rm $repj [y]"
	read key
	case $key in
		y) rm $repj;;
		*) exit ;;
	esac
	n=`cat $conj|jq length`
	n=`expr $n - 1`
	for ((i=0; i<=$n; i++ )) do
		f=`cat $conj|jq -r ".[$i].dir"`
		if [ -n "$f" ];then
			ff=`zsh -c "cd $f;ls -A ."`
			for (( ii=1;ii<=`echo "$ff"|wc -l`;ii++ ))
			do
				if [ $i -eq 0 ] && [ $ii -eq 1 ];then
					echo "[" >> $repj
				fi
				fff=`echo "$ff"|awk "NR==$ii"`
				if zsh -c "ls $f/$fff/.git" > /dev/null 2>&1;then
					echo $f/$fff
					tmp="{\"dir\":\"$f/$fff\"}," 
					echo "$tmp" >> $repj
				fi
			done
		fi
	done

fi

if ! cat $repj | jq . > /dev/null 2>&1;then
	case $OSTYPE in
		darwin*)
			sed -i "" '$s/,$/]/g' $repj
		;;
		linux*)
			sed -i '$s/,$/]/g' $repj
		;;
	esac
	cat $repj | jq .
fi
