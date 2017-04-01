#!/bin/zsh

if [ ! -d $conf ];then
	mkdir -p $conf
fi

if [ ! -f $conj ];then
	echo "{\"dir\":\"\"}" >> $conj
fi

if [ ! -d $json ];then
	mkdir -p $json
fi

