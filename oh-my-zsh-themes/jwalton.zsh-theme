# See /usr/share/zsh/5.3/functions/colors for color info (found from $fpath).
local prompt_color="%{$fg_bold[blue]%}"
local git_color="%{$fg_bold[yellow]%}"

local prompt_time="%{$fg_bold[black]%}%D{%H:%M:%S}"
local prompt_user="${prompt_color}[%n@%m %~]"

local ret_status="%(?..%{$fg_bold[red]%}⚠ )"
local prompt_marker="%(!.#.$)"

PROMPT='${prompt_time} ${prompt_user} $(git_prompt_info)${ret_status}${prompt_color}${prompt_marker}%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="${git_color}("
ZSH_THEME_GIT_PROMPT_SUFFIX="${prompt_color} "

ZSH_THEME_GIT_PROMPT_DIRTY=" Δ${git_color})"
ZSH_THEME_GIT_PROMPT_CLEAN=")"
