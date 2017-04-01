#!/bin/zsh

a=${0:a:h}/add.so
if [ -f $a ];then
	. $a
fi

$scp/mkdir.zsh

case $1 in
	set|s)
		$scp/set.zsh $*
	;;
	rebase|r)
		$scp/rebase.zsh $*
	;;
	pull|p)
		$scp/pull.zsh $*
	;;
	help|[hH]|-[hH]|--[hH])
		cat $scp/main.zsh
	;;
esac

