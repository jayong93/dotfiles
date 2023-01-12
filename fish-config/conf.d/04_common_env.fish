set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
function help
    $argv --help 2>&1 | bat --plain --language=help
end

function multicd
    echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end
abbr --add dotdot --regex '^\.\.+$' --function multicd
