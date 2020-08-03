# This is a work in progress.

# Pass color as a string in "<r>;<g>;<b>" format.  e.g. "255;0;0" for red.
set_foreground() {
    print -n $'\033[38;2;'$1'm'
}
set_background() {
    print -n $'\033[48;2;'$1'm'
}

local SEGMENT_SEPARATOR=$(print -n "\ue0b0")
local PLUSMINUS="\u00b1"
local BRANCH="\ue0a0"
local DETACHED="\u27a6"
local CROSS="\u2718"
local LIGHTNING="\u26a1"
local GEAR="\u2699"

time_segment_background='85;85;85'
time_segment_foreground='255;255;255'
user_segment_background='0;0;170'
user_segment_foreground='255;255;255'
git_segment_background='0;0;0'
git_segment_foreground='255;255;0'
prompt_color="%{$fg_bold[blue]%}"

CURRENT_BG='none'

prompt_segment() {
    local newBg=$1
    local newFg=$2

    if [[ $CURRENT_BG != 'none' ]]; then
        print -n "%{$(set_foreground $CURRENT_BG)$(set_background $newBg)%}$SEGMENT_SEPARATOR "
        print -n "%{$(set_foreground $newFg)%}"
    else
        print -n "%{$(set_background $newBg)$(set_foreground $newFg)%}"
    fi

    CURRENT_BG="${1}"
}

prompt_end() {
    CURRENT_BG='none'
}

prompt_time_segment() {
    prompt_segment $time_segment_background $time_segment_foreground
    print -n "%D{%H:%M:%S}"
}

prompt_user_segment() {
    prompt_segment $user_segment_background $user_segment_foreground
    print -n "%n@%m %~"
}

prompt_git_segment() {
    prompt_segment $git_segment_background $git_segment_foreground
    print -n $(git_prompt_info)
}

prompt_show() {
    prompt_time_segment
    prompt_user_segment
    prompt_git_segment
    print -n " ${prompt_color}${prompt_marker}%{$reset_color%}"
    prompt_end
}

local prompt_time="%{$time_segment_color%}%D{%H:%M:%S}"
local prompt_user="${prompt_color}[%n@%m %~]"

local ret_status="%(?..%{$fg_bold[red]%}⚠ )"
local prompt_marker="%(!.#.$)"
PROMPT='$(prompt_show) '

ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_DIRTY=" Δ)"
ZSH_THEME_GIT_PROMPT_CLEAN=")"
ZSH_THEME_GIT_PROMPT_SUFFIX=" "

