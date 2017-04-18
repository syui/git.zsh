#!/bin/zsh

. $scp/upstream.so

case $2 in
	p)
		git-zsh-upstream	
		git_zsh_local_file=`echo "$git_zsh_local_file"|peco`
		echo "git checkout --ours [y]"
		read yes
		case $yes in
			y)
				entry_command=`echo "$git_zsh_local_file"|sed 's/^/git checkout \-\-ours /g'`
				git checkout --theirs .
				zsh -c $entry_command
				git commit -m "mearge : upstream"
		
			;;
		esac
	;;
	a|"")
		git-zsh-upstream	
		echo "git checkout --ours {$no_update_select}"
		echo "$git_zsh_local_file"
		echo "git checkout --ours [y]"
		read yes
		case $yes in
			y)
				entry_command=`echo "$git_zsh_local_file"|sed 's/^/git checkout \-\-ours /g'`
				git checkout --theirs .
				zsh -c $entry_command
				git add .
				git commit -m "mearge : upstream"
			;;
		esac
	;;
	h)
		echo "-n : git log number ($ git.zsh upstream -n 4)"
		cat ${0:a}
	;;
esac

