#!/usr/bin/env bash

__powerline() {

	############################################################################
	# Compatibility settings

	# Defines how to specify escape codes for colorization.
	#
	# Note: This script uses the 16-colors palette of the terminal. The “normal”
	# (0-7) range is usualy works with any methods, contrary to the “bright”
	# (8-15) range.
	#
	# Valid values:
	#
	# * `'aixterm'`: Use the aixterm’s escape codes explicitly. Recommended for
	# the Gnome Terminal.
	# * `'terminfo'` (default): Use `tput` to determine the escape codes to use
	# Does not work with many terminals for the “bright” (8-15) range.
	readonly POWERLINE_TERM_COLOR_ENCODING='terminfo'


	############################################################################
	# Symbols

	readonly PS_SYMBOL_DARWIN=''
	readonly PS_SYMBOL_LINUX='$'
	readonly PS_SYMBOL_OTHER='%'
	readonly GIT_BRANCH_SYMBOL='⑂ '
	readonly GIT_BRANCH_CHANGED_SYMBOL='+'
	readonly GIT_NEED_PUSH_SYMBOL='⇡'
	readonly GIT_NEED_PULL_SYMBOL='⇣'


	############################################################################
	# Terminal’s escape codes for colorization

	##__fg_color {index}
	# @param index The index of the color (0 to 15).
	# @return The escape code (escaped for `$PS1`) that set the specified
	# foreground color.
	__fg_color() {
		case "$POWERLINE_TERM_COLOR_ENCODING" in
			aixterm)
				if (($1 < 8)); then
					echo -n '\[\e[3'"$1"'m\]'
				else
					echo -n "\[\e[9$(($1 - 8))m\]"
				fi
				;;
			*)
				echo -n "\[$(tput setaf $1)\]"
				;;
		esac
	}

	##__bg_color {index}
	# @param index The index of the color (0 to 15).
	# @return The escape code (escaped for `$PS1`) that set the specified
	# background color.
	__bg_color() {
		case "$POWERLINE_TERM_COLOR_ENCODING" in
			aixterm)
				if (($1 < 8)); then
					echo -n '\[\e[4'"$1"'m\]'
				else
					echo -n "\[\e[10$(($1 - 8))m\]"
				fi
				;;
			*)
				echo -n "\[$(tput setab $1)\]"
				;;
		esac
	}


	# ANSI color scheme

	readonly POWERLINE_FG_BLACK="$(__fg_color   0)"
	readonly POWERLINE_FG_RED="$(__fg_color     1)"
	readonly POWERLINE_FG_GREEN="$(__fg_color   2)"
	readonly POWERLINE_FG_YELLOW="$(__fg_color  3)"
	readonly POWERLINE_FG_BLUE="$(__fg_color    4)"
	readonly POWERLINE_FG_MAGENTA="$(__fg_color 5)"
	readonly POWERLINE_FG_CYAN="$(__fg_color    6)"
	readonly POWERLINE_FG_WHITE="$(__fg_color   7)"	# Actually light gray
	readonly POWERLINE_FG_BRIGHT_BLACK="$(__fg_color    8)"	# Actually dark gray
	readonly POWERLINE_FG_BRIGHT_RED="$(__fg_color      9)"
	readonly POWERLINE_FG_BRIGHT_GREEN="$(__fg_color   10)"
	readonly POWERLINE_FG_BRIGHT_YELLOW="$(__fg_color  11)"
	readonly POWERLINE_FG_BRIGHT_BLUE="$(__fg_color    12)"
	readonly POWERLINE_FG_BRIGHT_MAGENTA="$(__fg_color 13)"
	readonly POWERLINE_FG_BRIGHT_CYAN="$(__fg_color    14)"
	readonly POWERLINE_FG_BRIGHT_WHITE="$(__fg_color   15)"

	readonly POWERLINE_BG_BLACK="$(__bg_color   0)"
	readonly POWERLINE_BG_RED="$(__bg_color     1)"
	readonly POWERLINE_BG_GREEN="$(__bg_color   2)"
	readonly POWERLINE_BG_YELLOW="$(__bg_color  3)"
	readonly POWERLINE_BG_BLUE="$(__bg_color    4)"
	readonly POWERLINE_BG_MAGENTA="$(__bg_color 5)"
	readonly POWERLINE_BG_CYAN="$(__bg_color    6)"
	readonly POWERLINE_BG_WHITE="$(__bg_color   7)"	# Actually light gray
	readonly POWERLINE_BG_BRIGHT_BLACK="$(__bg_color    8)"	# Actually dark gray
	readonly POWERLINE_BG_BRIGHT_RED="$(__bg_color      9)"
	readonly POWERLINE_BG_BRIGHT_GREEN="$(__bg_color   10)"
	readonly POWERLINE_BG_BRIGHT_YELLOW="$(__bg_color  11)"
	readonly POWERLINE_BG_BRIGHT_BLUE="$(__bg_color    12)"
	readonly POWERLINE_BG_BRIGHT_MAGENTA="$(__bg_color 13)"
	readonly POWERLINE_BG_BRIGHT_CYAN="$(__bg_color    14)"
	readonly POWERLINE_BG_BRIGHT_WHITE="$(__bg_color   15)"


	# Solarized color scheme

	readonly POWERLINE_FG_BASE03="$(__fg_color  8)"
	readonly POWERLINE_FG_BASE02="$(__fg_color  0)"
	readonly POWERLINE_FG_BASE01="$(__fg_color 10)"
	readonly POWERLINE_FG_BASE00="$(__fg_color 11)"
	readonly POWERLINE_FG_BASE0="$(__fg_color  12)"
	readonly POWERLINE_FG_BASE1="$(__fg_color  14)"
	readonly POWERLINE_FG_BASE2="$(__fg_color   7)"
	readonly POWERLINE_FG_BASE3="$(__fg_color  15)"

	readonly POWERLINE_BG_BASE03="$(__bg_color  8)"
	readonly POWERLINE_BG_BASE02="$(__bg_color  0)"
	readonly POWERLINE_BG_BASE01="$(__bg_color 10)"
	readonly POWERLINE_BG_BASE00="$(__bg_color 11)"
	readonly POWERLINE_BG_BASE0="$(__bg_color  12)"
	readonly POWERLINE_BG_BASE1="$(__bg_color  14)"
	readonly POWERLINE_BG_BASE2="$(__bg_color   7)"
	readonly POWERLINE_BG_BASE3="$(__bg_color  15)"

	#readonly POWERLINE_FG_YELLOW -> See ANSI.
	readonly POWERLINE_FG_ORANGE="$(__fg_color  9)"
	#readonly POWERLINE_FG_RED -> See ANSI.
	#readonly POWERLINE_FG_MAGENTA -> See ANSI.
	readonly POWERLINE_FG_VIOLET="$(__fg_color 13)"
	#readonly POWERLINE_FG_BLUE -> See ANSI.
	#readonly POWERLINE_FG_CYAN -> See ANSI.
	#readonly POWERLINE_FG_GREEN -> See ANSI.

	#readonly POWERLINE_BG_YELLOW -> See ANSI.
	readonly POWERLINE_BG_ORANGE="$(__bg_color  9)"
	#readonly POWERLINE_BG_RED -> See ANSI.
	#readonly POWERLINE_BG_MAGENTA -> See ANSI.
	readonly POWERLINE_BG_VIOLET="$(__bg_color 13)"
	#readonly POWERLINE_BG_BLUE -> See ANSI.
	#readonly POWERLINE_BG_CYAN -> See ANSI.
	#readonly POWERLINE_BG_GREEN -> See ANSI.


	############################################################################
	# Other escape codes

	# Used at the end of the prompt to ensure that all graphic attributes are
	# reset.
	#
	# EL (“Erase in Line”) is required to clear the background when the prompt
	# is line-wrapped.
	readonly POWERLINE_TERM_RESET_RENDITION="\[$(tput sgr0)$(tput el)\]"

	# Some common graphic settings.
	readonly POWERLINE_TERM_SGR0="\[$(tput sgr0)\]"	# Resets to default rendition.
	readonly POWERLINE_TERM_BOLD="\[$(tput bold)\]"	# Bold or increased intensity.
	readonly POWERLINE_TERM_UNDERLINE="\[$(tput smul)\]"
	readonly POWERLINE_TERM_BLINK="\[$(tput blink)\]"
	readonly POWERLINE_TERM_REVERSE_VIDEO="\[$(tput rev)\]"


	############################################################################
	# Segments

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
		[ -x "$(which git)" ] || return	# git not found

		# get current branch name or short SHA1 hash for detached head
		local branch="$(git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --always 2>/dev/null)"
		[ -n "$branch" ] || return  # git branch not found

		local marks

		# branch is modified?
		[ -n "$(git status --porcelain)" ] && marks+=" $GIT_BRANCH_CHANGED_SYMBOL"

		# how many commits local branch is ahead/behind of remote?
		local aheadN="$(git rev-list @{u}.. | wc -l)"
		local behindN="$(git rev-list ..@{u} | wc -l)"
		[ "$aheadN" -ne "0" ] && marks+=" $GIT_NEED_PUSH_SYMBOL$aheadN"
		[ "$behindN" -ne "0" ] && marks+=" $GIT_NEED_PULL_SYMBOL$behindN"

		# print the git branch segment without a trailing newline
		printf " $GIT_BRANCH_SYMBOL$branch$marks "
	}


	############################################################################
	# Prompt building

	ps1() {
		# Check the exit code of the previous command and display different
		# colors in the prompt accordingly.
		if [ $? -eq 0 ]; then
			local BG_EXIT="$POWERLINE_BG_GREEN"
		else
			local BG_EXIT="$POWERLINE_BG_RED"
		fi

		PS1="$POWERLINE_BG_BASE1$POWERLINE_FG_BASE3 \w "
		PS1+="$POWERLINE_BG_BLUE$POWERLINE_FG_BASE3$(__git_info)"
		PS1+="$BG_EXIT$POWERLINE_FG_BASE3 $PS_SYMBOL $POWERLINE_TERM_RESET_RENDITION "
	}

	PROMPT_COMMAND=ps1
}

__powerline
unset __powerline
