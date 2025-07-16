if status is-login
    set -gx PYTHON3_VSN 3.11.1
    set -gx PYTHON2_VSN 2.7.18
    set -gx OTP_VSN OTP_26.2.1_L5
    set -gx LGF_PROXY_TOKEN 'a2d6fedfd8a82905fbfa7c3782592985' # Juiz proxy token
    set -gx LGF_EMAIL 'jayong93@linecorp.com'
    set -gx LGF_GH_USER jayong93 # git.linecorp.com ID
    set -gx LGF_GH_TOKEN 'de891030707a284d5f1a227387cc10a13a19c780' #  a token registered in https://git.linecorp.com/settings/tokens
    set -gx ZK_NOTEBOOK_DIR ~/Documents/LINE_ZK
    set -gx EDITOR 'nvim'
    # fish_add_path --path ~/.pyenv/shims
    fish_add_path --path ~/.krew/bin
    fish_add_path --path ~/.mix/escripts
    fish_add_path --path "$HOME/.cache/rebar3/bin"
    fish_add_path --path "$HOME/.cargo/bin"
    fish_add_path --path "$HOME/.kerl/installations/$OTP_VSN/.cache/rebar3/bin"
    # if test -z (pgrep ssh-agent | string collect)
    #     eval (ssh-agent -c)
    #     set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
    #     set -Ux SSH_AGENT_PID $SSH_AGENT_PID
    # end
    # source ~/.kerl/installations/$OTP_VSN/activate.fish
    fish_add_path --append --path "$HOME/.local/bin"
    set -gx ERG_PATH ~/.erg
end
ulimit -n 1048576
# alias jj="jj --config-file '/Users/user/.config/jj-line.toml'"
alias rm=rip
source ~/.kerl/installations/$OTP_VSN/activate.fish
if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source
    zoxide init fish | source
    alias vi='nvim'
    alias vim='nvim'
    alias ls='eza'
    alias k='kubectl'
    alias y='yazi'
    alias lg='lazygit'
    direnv hook fish | source
    # pyenv init - | source
    # pyenv virtualenv-init - | source
end
