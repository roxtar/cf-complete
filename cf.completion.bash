#!/usr/bin/env bash
# Bash completion support for cf.

export COMP_WORDBREAKS=${COMP_WORDBREAKS/\:/}
export CFCOMPLETE_CONFIG_DIR=$HOME/.cfcomplete
mkdir -p $CFCOMPLETE_CONFIG_DIR
cp commands.txt $CFCOMPLETE_CONFIG_DIR

_cfcomplete() {
   cur=${COMP_WORDS[COMP_CWORD]}
   prev=${COMP_WORDS[1]}
   case ${COMP_CWORD} in
     1)
       COMMANDS=$(cat $CFCOMPLETE_CONFIG_DIR/commands.txt)
       COMPREPLY=($( compgen -W "$COMMANDS" -- $cur ))
       ;;
     *)
       COMMANDS=$(cf $prev --help | grep -A100 OPTIONS | grep -v OPTIONS| awk '{print $1;}')
       SPACE_GUID=$(cat ~/.cf/config.json  | jq -r .SpaceFields.Guid)
       APP_FILE=$HOME/.cfcomplete/$SPACE_GUID.txt
       if [[ ! -e $APP_FILE ]]; then
         cf curl /v2/spaces/$SPACE_GUID/summary | jq -r ".apps[] | .name" > $APP_FILE
       fi
       APPS=$(cat $APP_FILE)
       COMPREPLY=($( compgen -W "$COMMANDS $APPS" -- $cur ))
       ;;
   esac
   return 0
}

complete -o default -o nospace -F _cfcomplete cf

