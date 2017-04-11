#!/bin/zsh

. $scp/rebase.so

if [ -n "$2" ];then
	rdir=`cat $conj| jq -r '.[]|select(.rebase)|.rebase'|head -n 1`
	ll=`zsh -c "cd $rdir;ls -A"`
fi

case $2 in
	p)
		ll=`echo "$ll"|peco`
		for (( i=1;i<=`echo $ll|wc -l`;i++ ))
		do
			f=`echo "$ll"|awk "NR==$i"`
			cd $rdir/$f
			git-zsh-rebase
		done
	;;
	a)
		for (( i=1;i<=`echo $ll|wc -l`;i++ ))
		do
			f=`echo "$ll"|awk "NR==$i"`
			cd $rdir/$f
			git-zsh-rebase
		done
	;;
	h)
		cat ${0:a}
	;;
	"")
		if [ -d ./.git ];then
			git-zsh-rebase
		fi
	;;
esac

