#!/usr/bin/env bash
# Bash completion support for ssh.

export COMP_WORDBREAKS=${COMP_WORDBREAKS/\:/}

_cfcomplete() {
   cur=${COMP_WORDS[COMP_CWORD]}
   prev=${COMP_WORDS[COMP_CWORD-1]}
   case ${COMP_CWORD} in
     1)
       COMMANDS=$(cat commands.txt)
       COMPREPLY=($( compgen -W "$COMMANDS" -- $cur ))
       ;;
     2)
       COMMANDS=$(cf $prev --help | grep -A100 OPTIONS | grep -v OPTIONS| awk '{print $1;}')
       COMPREPLY=($( compgen -W "$COMMANDS" -- $cur ))
       ;;
     *)
       COMPREPLY=()
       ;;
   esac
   return 0
}

complete -o default -o nospace -F _cfcomplete cf

