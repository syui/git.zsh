#!/bin/zsh

if [ ! -f $repj ];then
	exit
fi

gitdir=`zsh -c "ls -A ."`
localdir=`pwd`
for (( i=1;i<=`echo "$gitdir"|wc -l`;i++ ))
do
	gitfile=`echo "$gitdir"|awk "NR==$i"`
	cd $localdir/$gitfile
	tmp=`git config --get remote.origin.url`
	repeat 3 tmp=${tmp#*/}
	echo $tmp
done

