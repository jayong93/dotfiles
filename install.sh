#!/bin/bash

# installation on Linux
install_Linux() {
    echo "Install fish for Linux" 1>&2

    dist_info=$(lsb_release -a)

    # requirements for Homebrew
    if echo "$dist_info" | grep -i -e 'ubuntu' -e 'debian' -e 'raspbian'; then
        sudo apt-get install build-essential procps curl file git
    elif echo "$dist_info" | grep -i -e 'fedora' -e 'centos' -e 'red hat'; then
        sudo yum groupinstall 'Development Tools'
        sudo yum install procps-ng curl file git
        sudo yum install libxcrypt-compat # needed by Fedora 30 and up
    else
        echo "Couldn' get dist info." 1>&2
        return 1
    fi

    # install Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
    test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    if ! which brew
        echo "Couldn't find brew. It may not be installed." 1>&2
        return 1
    fi

    brew install fish && exec fish ./install_impl.fish
}

# installation on OS X
install_Darwin() {
    echo "Install fish for OS X" 1>&2

    # install Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    test -e /opt/homebrew/bin/brew && eval $(/opt/homebrew/bin/brew shellenv)
    test -e /usr/local/bin/brew && eval $(/usr/local/bin/brew shellenv)
    if ! which brew
        echo "Couldn't find brew. It may not be installed." 1>&2
        return 1
    fi

    brew install fish && exec fish ./install_impl.fish
}

os_name=$(uname)
case $os_name in
    Linux | Darwin)
        install_$os_name
        ;;

    *)
        echo "Unknown OS name from 'uname'" 1>&2
        return 1
        ;;
esac
