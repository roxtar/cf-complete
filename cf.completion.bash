#!/usr/bin/env bash
# Bash completion support for ssh.

export COMP_WORDBREAKS=${COMP_WORDBREAKS/\:/}

_cfcomplete() {
   COMMANDS=$(cat commands.txt)
   cur=${COMP_WORDS[COMP_CWORD]}
   COMPREPLY=($( compgen -W "$COMMANDS" -- $cur ))
   return 0
}

complete -o default -o nospace -F _cfcomplete cf

