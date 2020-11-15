# See /usr/share/zsh/5.3/functions/colors for color info (found from $fpath).

# To set a specific color for the prompt on this host, add this to your ~/.zprofile:
#
#  autoload -U colors && colors
#  export HOST_COLOR="$fg_bold[yellow]"
#

local prompt_color="%{$fg_bold[blue]%}"
if [ -n "${HOST_COLOR}" ]; then
    prompt_color="%{$HOST_COLOR%}"
elif [ -n "${SSH_TTY}" ]; then
    # SSHed in from another machine
    prompt_color="%{$fg_bold[green]%}"
fi

local git_color="%{$fg_bold[yellow]%}"

local prompt_time="%{$fg_bold[black]%}%D{%H:%M:%S}"
local prompt_user="${prompt_color}[%n@%m %~]"

local ret_status="%(?..%{$fg_bold[red]%}⚠ )"
local prompt_marker="%(!.#.$)"

PROMPT='${prompt_time} ${prompt_user} $(__posh_git_echo)${ret_status}${prompt_color}${prompt_marker}%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="${git_color}("
ZSH_THEME_GIT_PROMPT_SUFFIX="${prompt_color} "

ZSH_THEME_GIT_PROMPT_DIRTY=" Δ${git_color})"
ZSH_THEME_GIT_PROMPT_CLEAN=")"
