# Mac 用設定

# emacsclient を ec で
function emacsclient
    /Applications/Emacs.app/Contents/MacOS/bin/emacsclient $argv
end


# emacsclient を ec で
function ec
    emacsclient -n $argv
end
