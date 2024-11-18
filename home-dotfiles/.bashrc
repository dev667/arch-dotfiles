#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


####################### Terminal prompt configuration ##########################

# PS1='$ '


# Terminology:
#
#    \u: the username of the current user.
#    \h: the hostname up to the first ..
#    \w: The full path of the current working directory. 
#    \W: the basename of the current working directory.
#    \$: displays # if the user is root, otherwise it shows $.
#    \A: Displays the current time in 24-hour format (HH:MM).

# Shows the user and the working directory
# PS1='[\u@\h \W \A] $ '

# The same in green
# PS1='\[\e[32m\][\u@\h \W \A]\$\[\e[0m\] '


##### Include the git branch when working on a git repository #####

# Function to get the current Git branch (with the right spacing)
git_branch() {
        local branch_name=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
        
        if [[ $? -eq 0 ]]; then
                if [[ -n "$branch_name" ]]; then
                        echo -e " $branch_name"
                else
                        echo -e ""
                fi
        fi
}

# Set PS1 with Git branch information (in green)
# PS1='[\u@\h \W \A \[\e[32m\]$(git_branch)\[\e[0m\]] \$ '

# Some coloring already, for the complete coloring see the functions below

# Same command in simple:
# PS1='\u@\h > \w > \A >$(yellow git_branch) \$ '



# Set PS1 based on the exit status of the last command (failure or valid)
set_prompt() {
        if [[ $? -ne 0 ]]; then
                # Red coloring for failure (bold with 1;31 // 0;31 is normal)
                PS1='\033[32m\u@\h\033[0m > \033[33m\w\033[0m > \A > $(red git_branch)\n\033[0;31m\$\033[0m '
        else
                # Green coloring for success
                PS1='\033[32m\u@\h\033[0m > \033[33m\w\033[0m > \A > $(blue git_branch)\n\033[32m\$\033[0m '

        fi
}


# Version 2
set_prompt2() {
        if [[ $? -ne 0 ]]; then
                # Red coloring for failure (bold with 1;31 // 0;31 is normal)
                PS1='\033[32m\u@\h\033[0m > \033[33m\w\033[0m > \A >$(red git_branch) \033[0;31m\$\033[0m '
        else
                # Green coloring for success
                PS1='\033[32m\u@\h\033[0m > \033[33m\W\033[0m > \A >$(blue git_branch) \033[32m\$\033[0m '

        fi
}

# Version 3 
set_prompt3() {
        # Green coloring for success
        PS1='\033[32m\u@\h\033[0m > \033[33m\W\033[0m > \A >$(blue git_branch) \033[32m\$\033[0m '
}


# For coloring, tput can be used too:
# PS1='\[$(tput setaf 4)\]\w > \$ '


PROMPT_COMMAND=set_prompt2

#################### Terminal prompt configuration end #########################



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


# Colorizing figlet [Optional]
function figlet_color() {
    local color_code=$1
    shift
    echo -e "${color_code}$(figlet "$@")\033[0m"
}

# Colorizing terminal output in a simple matter
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


# Prettier ls
zoxide_zl_pls() {
        z "$@" && pls
}

zoxide_zi_pls() {
        zi "$@" && pls
}

zoxide_za_pls() {
        z "$@" && pls -d=std
}


# Use this if you don't use pls
zoxide_zl_list() {
	z "$@" && ls -h --color=auto
}

zoxide_zi_list() {
	zi "$@" && ls -h --color=auto
}

zoxide_za_list() {
	z "$@" && ls -lah --color=auto
}

############### Shortcuts ##################

# List directories
# alias ls='ls -h --color=auto'
alias ls='pls $@'
# alias lsd='ls -lah | grep "^d"'
alias lsd='pls --no-files'
# alias ll='ls -lah'
alias ll='pls -a -d=std'
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
alias cd='zoxide_zl_pls'
alias zl='zoxide_zl_pls'
alias zi='zoxide_zi_pls'
# alias z='zoxide_zl_list' # Use zl instead!!

# Go and list all
alias zla='zoxide_za_pls'


# Just easier stuff
alias ff='fastfetch --logo-color-1 red'
alias hs='hugo server $@'
alias fe='bash ~/.feh'

# Easier sourcing
alias brc='. ~/.bashrc'
alias xrc='. ~/.xinitrc'


# Just for fun
alias dt='date | figlet -ctf Graceful | lolcat'
alias fire='aafire -driver curses | lolcat'



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
