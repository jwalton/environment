DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source "${DIR}/../home/.config/bash/colors.bash"

log() {
    echo "${BWhite}${1}${Color_Off}"
}

log_warn() {
    echo "${IYellow}** ${1}${Color_Off}"
}

log_error() {
    echo "${Red}** ${1}${Color_Off}"
}

log_debug() {
    echo "${IBlack}${1}${Color_Off}"
}