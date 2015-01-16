#!/usr/bin/env bash

__powerline() {

    # Unicode symbols
    readonly PS_SYMBOL_DARWIN=''
    readonly PS_SYMBOL_LINUX='$'
    readonly PS_SYMBOL_OTHER='%'
    readonly GIT_BRANCH_SYMBOL='⑂ '
    readonly GIT_BRANCH_CHANGED_SYMBOL='+'
    readonly GIT_NEED_PUSH_SYMBOL='⇡'
    readonly GIT_NEED_PULL_SYMBOL='⇣'

    # Solarized colorscheme (tput 256 colors)
    #
    # Won’t work with gnome-terminal.
	#readonly FG_BASE03="\[$(tput setaf 8)\]"
	#readonly FG_BASE02="\[$(tput setaf 0)\]"
	#readonly FG_BASE01="\[$(tput setaf 10)\]"
	#readonly FG_BASE00="\[$(tput setaf 11)\]"
	#readonly FG_BASE0="\[$(tput setaf 12)\]"
	#readonly FG_BASE1="\[$(tput setaf 14)\]"
	#readonly FG_BASE2="\[$(tput setaf 7)\]"
	#readonly FG_BASE3="\[$(tput setaf 15)\]"

	#readonly BG_BASE03="\[$(tput setab 8)\]"
	#readonly BG_BASE02="\[$(tput setab 0)\]"
	#readonly BG_BASE01="\[$(tput setab 10)\]"
	#readonly BG_BASE00="\[$(tput setab 11)\]"
	#readonly BG_BASE0="\[$(tput setab 12)\]"
	#readonly BG_BASE1="\[$(tput setab 14)\]"
	#readonly BG_BASE2="\[$(tput setab 7)\]"
	#readonly BG_BASE3="\[$(tput setab 15)\]"

	#readonly FG_YELLOW="\[$(tput setaf 3)\]"
	#readonly FG_ORANGE="\[$(tput setaf 9)\]"
	#readonly FG_RED="\[$(tput setaf 1)\]"
	#readonly FG_MAGENTA="\[$(tput setaf 5)\]"
	#readonly FG_VIOLET="\[$(tput setaf 13)\]"
	#readonly FG_BLUE="\[$(tput setaf 4)\]"
	#readonly FG_CYAN="\[$(tput setaf 6)\]"
	#readonly FG_GREEN="\[$(tput setaf 2)\]"

	#readonly BG_YELLOW="\[$(tput setab 3)\]"
	#readonly BG_ORANGE="\[$(tput setab 9)\]"
	#readonly BG_RED="\[$(tput setab 1)\]"
	#readonly BG_MAGENTA="\[$(tput setab 5)\]"
	#readonly BG_VIOLET="\[$(tput setab 13)\]"
	#readonly BG_BLUE="\[$(tput setab 4)\]"
	#readonly BG_CYAN="\[$(tput setab 6)\]"
	#readonly BG_GREEN="\[$(tput setab 2)\]"

    # Solarized colorscheme (explicit AINSI codes)
    #
    # See: http://misc.flogisoft.com/bash/tip_colors_and_formatting
    readonly FG_BASE03="\[\e[90m\]"
    readonly FG_BASE02="\[\e[30m\]"
    readonly FG_BASE01="\[\e[92m\]"
    readonly FG_BASE00="\[\e[93m\]"
    readonly FG_BASE0="\[\e[94m\]"
    readonly FG_BASE1="\[\e[96m\]"
    readonly FG_BASE2="\[\e[37m\]"
    readonly FG_BASE3="\[\e[97m\]"

    readonly BG_BASE03="\[\e[100m\]"
    readonly BG_BASE02="\[\e[40m\]"
    readonly BG_BASE01="\[\e[102m\]"
    readonly BG_BASE00="\[\e[103m\]"
    readonly BG_BASE0="\[\e[104m\]"
    readonly BG_BASE1="\[\e[106m\]"
    readonly BG_BASE2="\[\e[47m\]"
    readonly BG_BASE3="\[\e[107m\]"

    readonly FG_YELLOW="\[\e[33m\]"
    readonly FG_ORANGE="\[\e[91m\]"
    readonly FG_RED="\[\e[31m\]"
    readonly FG_MAGENTA="\[\e[35m\]"
    readonly FG_VIOLET="\[\e[95m\]"
    readonly FG_BLUE="\[\e[34m\]"
    readonly FG_CYAN="\[\e[36m\]"
    readonly FG_GREEN="\[\e[32m\]"

    readonly BG_YELLOW="\[\e[43m\]"
    readonly BG_ORANGE="\[\e[101m\]"
    readonly BG_RED="\[\e[41m\]"
    readonly BG_MAGENTA="\[\e[45m\]"
    readonly BG_VIOLET="\[\e[105m\]"
    readonly BG_BLUE="\[\e[44m\]"
    readonly BG_CYAN="\[\e[46m\]"
    readonly BG_GREEN="\[\e[42m\]"

    readonly DIM="\[$(tput dim)\]"
    readonly REVERSE="\[$(tput rev)\]"
    readonly RESET="\[$(tput sgr0)\]"
    readonly BOLD="\[$(tput bold)\]"

    # what OS?
    case "$(uname)" in
        Darwin)
            readonly PS_SYMBOL=$PS_SYMBOL_DARWIN
            ;;
        Linux)
            readonly PS_SYMBOL=$PS_SYMBOL_LINUX
            ;;
        *)
            readonly PS_SYMBOL=$PS_SYMBOL_OTHER
    esac

    __git_info() { 
        [ -x "$(which git)" ] || return    # git not found

        # get current branch name or short SHA1 hash for detached head
        local branch="$(git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --always 2>/dev/null)"
        [ -n "$branch" ] || return  # git branch not found

        local marks

        # branch is modified?
        [ -n "$(git status --porcelain)" ] && marks+=" $GIT_BRANCH_CHANGED_SYMBOL"

        # how many commits local branch is ahead/behind of remote?
        local stat="$(git status --porcelain --branch | grep '^##' | grep -o '\[.\+\]$')"
        local aheadN="$(echo $stat | grep -o 'ahead \d\+' | grep -o '\d\+')"
        local behindN="$(echo $stat | grep -o 'behind \d\+' | grep -o '\d\+')"
        [ -n "$aheadN" ] && marks+=" $GIT_NEED_PUSH_SYMBOL$aheadN"
        [ -n "$behindN" ] && marks+=" $GIT_NEED_PULL_SYMBOL$behindN"

        # print the git branch segment without a trailing newline
        printf " $GIT_BRANCH_SYMBOL$branch$marks "
    }

    ps1() {
        # Check the exit code of the previous command and display different
        # colors in the prompt accordingly. 
        if [ $? -eq 0 ]; then
            local BG_EXIT="$BG_GREEN"
        else
            local BG_EXIT="$BG_RED"
        fi

        PS1="$BG_BASE1$FG_BASE3 \w $RESET"
        PS1+="$BG_BLUE$FG_BASE3$(__git_info)$RESET"
        PS1+="$BG_EXIT$FG_BASE3 $PS_SYMBOL $RESET "
    }

    PROMPT_COMMAND=ps1
}

__powerline
unset __powerline
