set

function fish_prompt --description 'Write out the prompt'
	set laststatus $status

    set PROMPT_COLOR brblue
    set GIT_BRANCH_COLOR bryellow

    set TIME (printf '%s%s ' (set_color brblack) (date +%X))

    if test $laststatus -eq 0
        set LAST_STATUS (set_color $PROMPT_COLOR)
    else
        set LAST_STATUS (printf "%s%s" (set_color -o red) " ⚠")
    end

    if not set -q __fish_prompt_hostname
        set -g __fish_prompt_hostname (hostname -s)
    end

    if set -l git_branch (command git symbolic-ref HEAD 2>/dev/null | string replace refs/heads/ '')
        set git_branch (set_color $GIT_BRANCH_COLOR)"$git_branch"
        if command git diff-index --quiet HEAD --
            if set -l count (command git rev-list --count --left-right $upstream...HEAD 2>/dev/null)
                echo $count | read -l ahead behind
                if test "$ahead" -gt 0
                    set git_status "$git_status"(set_color red)⬆
                end
                if test "$behind" -gt 0
                    set git_status "$git_status"(set_color red)⬇
                end
            end
            for i in (git status --porcelain | string sub -l 2 | uniq)
                switch $i
                    case "."
                        set git_status "$git_status"(set_color green)✚
                    case " D"
                        set git_status "$git_status"(set_color red)✖
                    case "*M*"
                        set git_status "$git_status"(set_color green)✱
                    case "*R*"
                        set git_status "$git_status"(set_color purple)➜
                    case "*U*"
                        set git_status "$git_status"(set_color brown)═
                    case "??"
                        set git_status "$git_status"(set_color red)≠
                end
            end
        else
            set git_status ''
        end
        set git_info " "(set_color $GIT_BRANCH_COLOR)"($git_status$git_branch)"
    end

    set_color -b black brblack
    printf '[FISH] %s' $TIME
    set_color $PROMPT_COLOR
    printf '[%s@%s %s]%s' $USER $__fish_prompt_hostname (echo $PWD | sed -e "s|^$HOME|~|") $git_info
    printf '%s%s $ %s' $LAST_STATUS (set_color $PROMPT_COLOR) (set_color normal)
    set_color -b black
end
