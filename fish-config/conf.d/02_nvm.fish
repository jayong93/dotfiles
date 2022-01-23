if test -e ~/.nvm/nvm.sh
    function nvm
        bass source ~/.nvm/nvm.sh --no-use ';' nvm $argv
    end
    status is-login; and nvm use default --silent
end
