# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
if [ "$LC_TERMINAL" = "iTerm2" ]; then
    alias alert='echo $'\''\033]9;'\''"$([ $? = 0 ] && echo terminal || echo error)": "$(echo $history[$HISTCMD]|sed -E '\''s/^[ ]*(.*)[ ]*;[ ]*alert$/\1/'\'')"$'\''\007'\'''
elif [[ "$OSTYPE" == "darwin"* ]]; then
    alias alert="Alert not supported. :("
else
    alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(echo $history[$HISTCMD]|sed -e '\''s/^\s*//;s/[;&|]\s*alert$//'\'')"'
fi