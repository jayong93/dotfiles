set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
function help
    $argv --help 2>&1 | bat --plain --language=help
end
