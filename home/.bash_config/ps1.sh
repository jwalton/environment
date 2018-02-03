PS1DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source ${HOME}/.bash_config/colors.bash
# GIT PS1
source ${HOME}/.bash_config/git-prompt.sh

get_exit_status(){
   es=$?
   if [ $es -eq 0 ]
   then
       echo -e ""
   else
       echo -e "${BRed}${es} "
   fi
}

PS1_SET_TITLE="\[\033]0;\w\007\]"
PS1_TIME="\[${IBlack}\]${Time24h} "
PS1_USER="\[${IBlue}\][${PS1_User}@${PS1_Host} ${PathShort}] "
PS1_GIT="\[${IYellow}\]"'$(__git_ps1 "(%s) ")'
PS1_EXIT_STATUS='${exitStatus}'
PS1_PROMPT="\[${IBlue}\]$ \[${Color_Off}\]"
export PS1="${PS1_SET_TITLE}${PS1_TIME}${PS1_USER}${PS1_GIT}${PS1_EXIT_STATUS}${PS1_PROMPT}"

# Default to current directory as title
export PROMPT_COMMAND='exitStatus=$(get_exit_status)'

setXtermTitle()
{
   # echo -ne "\033]0;$1\007"
   export PS1="\[\033]0;$1 \w\007\]$ORIG_PS1"
}

alias title=setXtermTitle

