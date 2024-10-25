#
# ~/.bashrc
#

# If not running interactively, don't do anything
#[[ $- != *i* ]] && return



alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
#PS1='$ '




### Functions ###
#
# Installer and remapping functions
nvim_wrapper() {
	if [ -x "$(command -v nvim)" ]; then
		nvim "$@"
	else
		echo "Neovim is not installed. Installing now..."
		sudo pacman -S neovim
		nvim "$@"
	fi
}

batman() {
	if [ -x "$(command -v bat)" ]; then
            bat "$@"
            return  # Exit the function after running bat
        else
            echo "Bat is not installed."
            read -p "Do you want to install bat now? (y/n): " choice
            if [[ "$choice" == "y" ]]; then
                echo "Installing bat now..."
                sudo pacman -S --noconfirm bat  # Install without asking for confirmation
                bat "$@"
            else
                echo "Exiting the program..."
            fi
        fi
}

# Colorizing figlet
function figlet_color() {
    local color_code=$1
    shift
    echo -e "${color_code}$(figlet "$@")\033[0m"
}

# Colorizing terminal output
function red() { echo -e "\033[31m$("$@")\033[0m"; }

function yellow() { echo -e "\033[33m$("$@")\033[0m"; }

function blue() { echo -e "\033[34m$("$@")\033[0m"; }

function green() { echo -e "\033[32m$("$@")\033[0m"; }

function cyan() { echo -e "\033[36m$("$@")\033[0m"; }

function pink() { echo -e "\033[35m$("$@")\033[0m"; }

function white() { echo -e "\033[37m$("$@")\033[0m"; }

function black() { echo -e "\033[30m$("$@")\033[0m"; }



# Initializing commands like fuck and zoxide
eval "$(thefuck --alias)"
eval "$(zoxide init bash)"


zoxide_zl_list() {
	z "$@" && ls
}

zoxide_zi_list() {
	zi "$@" && ls
}

zoxide_za_list() {
	z "$@" && ls -lah
}

############### Shortcuts ##################

# List directories
# alias ls='ls'
alias lsd='ls -lah | grep "^d"'
alias ll='ls -lah'
alias cat='batman'


# Garbage stuff
alias rm='trash-put $@'
alias tl='trash-list'


# Neovim
alias nv='nvim_wrapper'
alias vi='nvim_wrapper'
alias vim='nvim_wrapper'


# audio
alias audio='wpctl get-volume @DEFAULT_AUDIO_SINK@' # Show volume level
alias ++='wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+' # Increase volume
alias +-='wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-' # Lower volume
alias mute='wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle' # Mute


# maybe brightness control someday
#
#


### Go to helper ###

# Go to and list
alias cd='zoxide_zl_list'
alias zl='zoxide_zl_list'
alias zi='zoxide_zi_list'
# alias z='zoxide_zl_list' # Use zl instead!!

# Go and list all
alias zla='zoxide_za_list'


# Just easier stuff
alias ff='fastfetch --logo-color-1 red'
alias hs='hugo server $@'
alias brc='. ~/.bashrc'


# Just for fun
alias dt='date | figlet -ctf Graceful | lolcat'
alias fire!='aafire -driver curses | lolcat'



# Git
alias gs='git status $@'
alias gc='git commit -m $@'

# Scripting shortcuts
# wifi
alias wifia='sudo nmcli dev wifi connect _Free_Wifi_Berlin'

# Optional programs to map
alias yg='you-get $@'
################# Shortcuts end ##################


# date | figlet -ctf smslant | lolcat
# ff | lolcat
# ff
# figlet -ctf poison Arch Linux | lolcat
cyan figlet -ctf poison Arch Linux


source $HOME/.config/broot/launcher/bash/br
