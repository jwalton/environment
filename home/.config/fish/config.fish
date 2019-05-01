if test -e ~/.config/fish/.iterm2_shell_integration.fish
    source ~/.config/fish/.iterm2_shell_integration.fish
else
    echo (set_color red)"Missing iterm2 shell integration."
end

