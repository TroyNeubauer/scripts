function cd --wraps=cd\ if\ ls\ -a\ \|\ grep\ -e\ \'.git\'
builtin cd $argv
if /usr/bin/ls -a | grep -q -e '.git'
git log --pretty=oneline --graph --decorate --all -n 10
end
end
