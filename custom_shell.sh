
echo " 
 ______________________
|  __________________  |
| | Shell Customizer | |
| |  By Jeremy Boyle | |
| |__________________| |
|______________________|"
echo "starting.... "

username=$(whoami)
install_zsh () {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if [ -n "apt" ]; then
            sleep 1
            echo "Pulling Updates..."

            sudo apt-get update -y
            #verify command ran without errors
            if [ $? != 0 ]; then
                echo "Failed to update packages, check connection !! exiting" && exit
                elif [ $? == 1 ]; then
                    echo "Success !"
                    sleep 2
                    clear
                else
                echo "Not sure what happened" && exit
            fi

            echo "Installing ZSH..."
            sleep 2

            sudo apt-get install zsh -y
            #verify command ran without errors
            if [ $? != 0 ]; then
                echo "Failed to install zsh, check connection !! exiting" && exit
                elif [ $? == 1 ]; then
                    echo "Success !"
                    sleep 2
                    clear
                else
                echo "Not sure what happened" && exit
            fi
            touch ~/.zshrc
            sleep 2
        fi
    fi
}

install_vim () {
    if [ -n "apt" ]; then
        sleep 1
        echo "Pulling Updates..."

        sudo apt-get update -y || echo "error" && echo "Updated apt"

        echo "Installing VIM , Git, Curl..."
        sleep 2

        sudo apt-get install vim git curl -y || echo "error" && echo "Installed Git and Curl"
        sleep 2
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install curl || echo "error" && echo "Installed Curl"
        brew install git || echo "error" && echo "Installed Git"
        brew install vim || echo "error" && echo "Installed Vim"
        sleep 2
        clear
    fi
    echo "Making dirs.."
    mkdir ~/.vim ~/.vim/colors ~/.vim/autoload
    echo "Downloading Theme files.."
    curl https://raw.githubusercontent.com/joshdick/onedark.vim/master/colors/onedark.vim -o ~/.vim/colors/onedark.vim
    curl https://raw.githubusercontent.com/Jeremy-Boyle/Shell-Customizer/main/.vimrc -o ~/.vimrc
    echo "Installing Syntax plugins"
    git clone --depth 1 https://github.com/sheerun/vim-polyglot ~/.vim/pack/plugins/start/vim-polyglot
    echo "Installing Command Themes"
    git clone https://github.com/vim-airline/vim-airline ~/.vim/pack/plugins/start/vim-airline
    echo "Downloading last files!"
    curl https://raw.githubusercontent.com/joshdick/onedark.vim/master/autoload/onedark.vim -o ~/.vim/autoload/onedark.vim
    curl https://raw.githubusercontent.com/joshdick/onedark.vim/master/autoload/airline/themes/onedark.vim -o ~/.vim/pack/plugins/start/vim-airline/autoload/airline/themes/onedark.vim
    sleep 1
}

install_oh_my_zsh () {

    set -e

    # Track if $ZSH was provided
    custom_zsh=${ZSH:+yes}

    # Default settings
    ZSH=${ZSH:-~/.oh-my-zsh}
    REPO=${REPO:-ohmyzsh/ohmyzsh}
    REMOTE=${REMOTE:-https://github.com/${REPO}.git}
    BRANCH=${BRANCH:-master}

    # Other options
    CHSH=${CHSH:-yes}
    RUNZSH=${RUNZSH:-yes}
    KEEP_ZSHRC=${KEEP_ZSHRC:-no}


    command_exists() {
        command -v "$@" >/dev/null 2>&1
    }

    fmt_error() {
    printf '%sError: %s%s\n' "$BOLD$RED" "$*" "$RESET" >&2
    }

    fmt_underline() {
    printf '\033[4m%s\033[24m\n' "$*"
    }

    fmt_code() {
    # shellcheck disable=SC2016 # backtic in single-quote
    printf '`\033[38;5;247m%s%s`\n' "$*" "$RESET"
    }

    setup_color() {
        # Only use colors if connected to a terminal
        if [ -t 1 ]; then
            RED=$(printf '\033[31m')
            GREEN=$(printf '\033[32m')
            YELLOW=$(printf '\033[33m')
            BLUE=$(printf '\033[34m')
            BOLD=$(printf '\033[1m')
            RESET=$(printf '\033[m')
        else
            RED=""
            GREEN=""
            YELLOW=""
            BLUE=""
            BOLD=""
            RESET=""
        fi
    }

    setup_ohmyzsh() {
    # Prevent the cloned repository from having insecure permissions. Failing to do
    # so causes compinit() calls to fail with "command not found: compdef" errors
    # for users with insecure umasks (e.g., "002", allowing group writability). Note
    # that this will be ignored under Cygwin by default, as Windows ACLs take
    # precedence over umasks except for filesystems mounted with option "noacl".
    umask g-w,o-w

    # Install git
    isntall_git(){
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            sudo apt-get install git -y || echo "error" && echo "Installed"
        elif [[ "$OSTYPE" == "darwin"* ]]; then
            brew install git || echo "error" && echo "Installed"
        fi
    }

    # Install curl
    isntall_curl(){
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            sudo apt-get install curl -y || echo "error" && echo "Installed"
        elif [[ "$OSTYPE" == "darwin"* ]]; then
            brew install curl || echo "error" && echo "Installed"
        fi
    }

    echo "${BLUE}Cloning Oh My Zsh...${RESET}"

    command_exists git || {
        fmt_error "git is not installed "
        while true; do
            read -p "Would like to install git? y/n: " yn
            case $yn in
                [Yy]* ) isntall_git; break;;
                [Nn]* ) exit;;
                * ) echo "Please answer yes or no.";;
            esac
        done
    }

    command_exists curl || {
        fmt_error "curl is not installed "
        while true; do
            read -p "Would like to install curl? y/n: " yn
            case $yn in
                [Yy]* ) isntall_curl; break;;
                [Nn]* ) exit;;
                * ) echo "Please answer yes or no.";;
            esac
        done
    }
    
    if [[ "$OSTYPE" == "darwin"* ]]; then
        command_exists brew || {
            fmt_error "brew is not installed, please install it first"
            exit 1
        }
    fi

    ostype=$(uname)
    if [ -z "${ostype%CYGWIN*}" ] && git --version | grep -q msysgit; then
        fmt_error "Windows/MSYS Git is not supported on Cygwin"
        fmt_error "Make sure the Cygwin git package is installed and is first on the \$PATH"
        exit 1
    fi

    git clone -c core.eol=lf -c core.autocrlf=false \
        -c fsck.zeroPaddedFilemode=ignore \
        -c fetch.fsck.zeroPaddedFilemode=ignore \
        -c receive.fsck.zeroPaddedFilemode=ignore \
        --depth=1 --branch "$BRANCH" "$REMOTE" "$ZSH" || {
        fmt_error "git clone of oh-my-zsh repo failed"
        exit 1
    }
}

setup_zshrc() {
    # Keep most recent old .zshrc at .zshrc.pre-oh-my-zsh, and older ones
    # with datestamp of installation that moved them aside, so we never actually
    # destroy a user's original zshrc
    echo "${BLUE}Looking for an existing zsh config...${RESET}"

    # Must use this exact name so uninstall.sh can find it
    OLD_ZSHRC=~/.zshrc.pre-oh-my-zsh
    if [ -f ~/.zshrc ] || [ -h ~/.zshrc ]; then
        # Skip this if the user doesn't want to replace an existing .zshrc
        if [ "$KEEP_ZSHRC" = yes ]; then
        echo "${YELLOW}Found ~/.zshrc.${RESET} ${GREEN}Keeping...${RESET}"
        return
        fi
        if [ -e "$OLD_ZSHRC" ]; then
        OLD_OLD_ZSHRC="${OLD_ZSHRC}-$(date +%Y-%m-%d_%H-%M-%S)"
        if [ -e "$OLD_OLD_ZSHRC" ]; then
            fmt_error "$OLD_OLD_ZSHRC exists. Can't back up ${OLD_ZSHRC}"
            fmt_error "re-run the installer again in a couple of seconds"
            exit 1
        fi
        mv "$OLD_ZSHRC" "${OLD_OLD_ZSHRC}"

        echo "${YELLOW}Found old ~/.zshrc.pre-oh-my-zsh." \
            "${GREEN}Backing up to ${OLD_OLD_ZSHRC}${RESET}"
        fi
        echo "${YELLOW}Found ~/.zshrc.${RESET} ${GREEN}Backing up to ${OLD_ZSHRC}${RESET}"
        mv ~/.zshrc "$OLD_ZSHRC"
    fi

    echo "${GREEN}Using the Oh My Zsh template file and adding it to ~/.zshrc.${RESET}"

    sed "/^export ZSH=/ c\\
    export ZSH=\"$ZSH\"
    " "$ZSH/templates/zshrc.zsh-template" > ~/.zshrc-omztemp
        mv -f ~/.zshrc-omztemp ~/.zshrc

        echo
}

setup_shell() {
    # Skip setup if the user wants or stdin is closed (not running interactively).
    if [ "$CHSH" = no ]; then
        return
    fi

    # If this user's login shell is already "zsh", do not attempt to switch.
    if [ "$(basename -- "$SHELL")" = "zsh" ]; then
        return
    fi

  # If this platform doesn't provide a "chsh" command, bail out.
    if ! command_exists chsh; then
    cat <<EOF
I can't change your shell automatically because this system does not have chsh.
${BLUE}Please manually change your default shell to zsh${RESET}
EOF
        return
    fi

    echo "${BLUE}Time to change your default shell to zsh:${RESET}"

    # Prompt for user choice on changing the default login shell
    printf '%sDo you want to change your default shell to zsh? [Y/n]%s ' \
        "$YELLOW" "$RESET"
    read -r opt
    case $opt in
        y*|Y*|"") echo "Changing the shell..." ;;
        n*|N*) echo "Shell change skipped."; return ;;
        *) echo "Invalid choice. Shell change skipped."; return ;;
    esac

    # Check if we're running on Termux
    case "$PREFIX" in
        *com.termux*) termux=true; zsh=zsh ;;
        *) termux=false ;;
    esac

    if [ "$termux" != true ]; then
        # Test for the right location of the "shells" file
        if [ -f /etc/shells ]; then
        shells_file=/etc/shells
        elif [ -f /usr/share/defaults/etc/shells ]; then # Solus OS
        shells_file=/usr/share/defaults/etc/shells
        else
        fmt_error "could not find /etc/shells file. Change your default shell manually."
        return
        fi

        # Get the path to the right zsh binary
        # 1. Use the most preceding one based on $PATH, then check that it's in the shells file
        # 2. If that fails, get a zsh path from the shells file, then check it actually exists
        if ! zsh=$(command -v zsh) || ! grep -qx "$zsh" "$shells_file"; then
        if ! zsh=$(grep '^/.*/zsh$' "$shells_file" | tail -1) || [ ! -f "$zsh" ]; then
            fmt_error "no zsh binary found or not present in '$shells_file'"
            fmt_error "change your default shell manually."
            return
        fi
        fi
    fi

    # We're going to change the default shell, so back up the current one
    if [ -n "$SHELL" ]; then
        echo "$SHELL" > ~/.shell.pre-oh-my-zsh
    else
        grep "^$USERNAME:" /etc/passwd | awk -F: '{print $7}' > ~/.shell.pre-oh-my-zsh
    fi

    # Actually change the default shell to zsh
    if ! sudo chsh -s "$zsh"; then
        fmt_error "chsh command unsuccessful. Change your default shell manually."
    else
        export SHELL="$zsh"
        echo "${GREEN}Shell successfully changed to '$zsh'.${RESET}"
    fi

    echo
}

main() {
    # Run as unattended if stdin is not a tty
    if [ ! -t 0 ]; then
        RUNZSH=no
        CHSH=no
    fi

    # Parse arguments
    while [ $# -gt 0 ]; do
        case $1 in
        --unattended) RUNZSH=no; CHSH=no ;;
        --skip-chsh) CHSH=no ;;
        --keep-zshrc) KEEP_ZSHRC=yes ;;
        esac
        shift
    done

    setup_color

    if [! command_exists zsh]; then
        echo "${YELLOW}Zsh is not installed.${RESET} Please install zsh first."
        exit 1
    fi

    if [ -d "$ZSH" ]; then
        echo "${YELLOW}The \$ZSH folder already exists ($ZSH).${RESET}"
        if [ "$custom_zsh" = yes ]; then
      cat <<EOF

You ran the installer with the \$ZSH setting or the \$ZSH variable is
exported. You have 3 options:

1. Unset the ZSH variable when calling the installer:
   $(fmt_code "ZSH= sh install.sh")
2. Install Oh My Zsh to a directory that doesn't exist yet:
   $(fmt_code "ZSH=path/to/new/ohmyzsh/folder sh install.sh")
3. (Caution) If the folder doesn't contain important information,
   you can just remove it with $(fmt_code "rm -r $ZSH")

EOF
        else
        echo "You'll need to remove it if you want to reinstall."
        fi
    fi

    setup_ohmyzsh
    setup_zshrc
    setup_shell

    printf %s "$GREEN"
    cat <<'EOF'
         __                                     __
  ____  / /_     ____ ___  __  __   ____  _____/ /_
 / __ \/ __ \   / __ `__ \/ / / /  /_  / / ___/ __ \
/ /_/ / / / /  / / / / / / /_/ /    / /_(__  ) / / /
\____/_/ /_/  /_/ /_/ /_/\__, /    /___/____/_/ /_/
                        /____/                       ....is now installed!


EOF

    cat <<EOF
    • Installing plugins / themes now!

EOF
    printf %s "$RESET"
    #Check if the os is mac and add
    if [[ "$OSTYPE" == "darwin"* ]]; then
        sed -i '' -e 's/(git)/(zsh-syntax-highlighting zsh-completions git kubectl aws brew docker history osx)/g' ~/.zshrc
    else
        sed -i 's/(git)/(zsh-syntax-highlighting zsh-completions git kubectl aws docker history)/g' ~/.zshrc
    fi

    echo "${BLUE}Cloning powerlevel10k${RESET}"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    clear
    echo "${BLUE}Cloning zsh-syntax-highlighting${RESET}"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    clear
    echo "${BLUE}Cloning zsh-completions${RESET}"
    git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
    if [[ "$OSTYPE" == "darwin"* ]]; then
        sed -i '' -e 's/robbyrussell/powerlevel10k\/powerlevel10k/g' ~/.zshrc
    else
        sed -i 's/robbyrussell/powerlevel10k\/powerlevel10k/g' ~/.zshrc
    fi
    while true; do
        clear
        read -p "Would like to install the sfw theme? y/n: " yn
        case $yn in
            [Yy]* ) curl https://raw.githubusercontent.com/Jeremy-Boyle/Shell-Customizer/main/.p10k.zsh -o .p10k.zsh && echo "[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh" >> ~/.zshrc ; break;;
            [Nn]* ) echo "Okay ill let you set it up!"; break;;
            * ) echo "Please answer yes or no.";;
        esac
    done    
    exec zsh -l
}
    main "$@"
}

if [ -n "$BASH_VERSION" ]; then
    # assume Bash
    if [[ "$OSTYPE" != "darwin"* ]];then    
        while true; do
            echo ""
            read -p "Hello $username would like to install zsh? y/n: " yn
            case $yn in
                [Yy]* ) install_zsh; break;;
                [Nn]* ) break;;
                * ) echo "Please answer yes or no.";;
            esac
        done
    fi
fi

while true; do
    echo ""
    read -p "Would like to install vim syntax and themes? y/n: " yn
    case $yn in
        [Yy]* ) install_vim; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

if [ -n "echo $ZSH_VERSION" ]; then
    # assume Bash
    while true; do
        echo ""
        read -p "Would like to install oh-my-zsh with themes? y/n: " yn
        case $yn in
            [Yy]* ) install_oh_my_zsh; break;;
            [Nn]* ) exit;;
            * ) echo "Please answer yes or no.";;
        esac
    done
fi