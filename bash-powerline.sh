#!/usr/bin/env bash

# A Powerline Bash prompt.
#
# Available settings:
#
# * `POWERLINE_TERM_COLOR_ENCODING` (“Compatibility settings” section)
# * `POWERLINE_SYMBOL_*` (“Symbols” section)
# * `POWERLINE_LOOK_*` and `POWERLINE_SBAF_*` (“Segment look” section)
# * `ps1`
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

	# The character at the end of a segment.
	#
	# Examples:
	#
	# * `'█ '`: “boxy” style
	# * `' '`: The original Powerline style. As the orignal Powerline, this
	#   require a patched font. See
	# <https://powerline.readthedocs.org/en/latest/installation.html#fonts-installation>.
	# * `'█▒ '`
	readonly POWERLINE_SYMBOL_SEGMENT_END='█▚ '

	readonly POWERLINE_SYMBOL_OS_DARWIN=''
	readonly POWERLINE_SYMBOL_OS_LINUX='$'
	readonly POWERLINE_SYMBOL_OS_OTHER='%'
	readonly POWERLINE_SYMBOL_BRANCH='⑂ '
	readonly POWERLINE_SYMBOL_DIRTY='+'
	readonly POWERLINE_SYMBOL_COMMITS_AHEAD='⇡'
	readonly POWERLINE_SYMBOL_COMMITS_BEHIND='⇣'
	readonly POWERLINE_SYMBOL_CHROOT='⦿ '
	readonly POWERLINE_SYMBOL_FAILURE='!'


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
	# Segment look
	#
	# The `POWERLINE_LOOK_*` constants specify escape codes to print before the
	# content while the `POWERLINE_SBAF_` (“set background as foreground”)
	# constants specify the escape code that sets the background of the
	# corresponding segment as the foreground (needed to render divisions).
	#
	# You may use the constants defined in the “Terminal’s escape codes for
	# colorization” and “Other escape codes” sections.

	# Sets the default background as the foreground.
	# Used to end the last segment.
	readonly POWERLINE_SBAF_DEFAULT="$POWERLINE_FG_BASE3"

	# __segment_failure
	readonly POWERLINE_LOOK_FAILURE="$POWERLINE_BG_RED$POWERLINE_FG_BASE3"
	readonly POWERLINE_SBAF_FAILURE="$POWERLINE_FG_RED"

	# __segment_chroot
	readonly POWERLINE_LOOK_CHROOT="$POWERLINE_BG_CYAN$POWERLINE_FG_BASE3"
	readonly POWERLINE_SBAF_CHROOT="$POWERLINE_FG_CYAN"

	# __segment_user (all)
	readonly POWERLINE_LOOK_USER="$POWERLINE_FG_BASE3"
	readonly POWERLINE_SBAF_USER=''

	# __segment_user (non-root user)
	# Combined with `POWERLINE_LOOK_USER` and `POWERLINE_SBAF_USER`.
	readonly POWERLINE_LOOK_USER_NORMAL="$POWERLINE_BG_GREEN"
	readonly POWERLINE_SBAF_USER_NORMAL="$POWERLINE_FG_GREEN"

	# __segment_user (root user)
	# Combined with `POWERLINE_LOOK_USER` and `POWERLINE_SBAF_USER`.
	readonly POWERLINE_LOOK_USER_ROOT="$POWERLINE_BG_ORANGE"
	readonly POWERLINE_SBAF_USER_ROOT="$POWERLINE_FG_ORANGE"

	# __segment_prompt_os (all)
	readonly POWERLINE_LOOK_PROMPT_OS="$POWERLINE_FG_BASE3"
	readonly POWERLINE_SBAF_PROMPT_OS=''

	# __segment_prompt_os (success)
	# Combined with `POWERLINE_LOOK_PROMPT_OS` and `POWERLINE_SBAF_PROMPT_OS`.
	readonly POWERLINE_LOOK_PROMPT_OS_OK="$POWERLINE_BG_GREEN"
	readonly POWERLINE_SBAF_PROMPT_OS_OK="$POWERLINE_FG_GREEN"

	# __segment_prompt_os (previous command failed)
	# Combined with `POWERLINE_LOOK_PROMPT_OS` and `POWERLINE_SBAF_PROMPT_OS`.
	readonly POWERLINE_LOOK_PROMPT_OS_FAILED="$POWERLINE_BG_RED"
	readonly POWERLINE_SBAF_PROMPT_OS_FAILED="$POWERLINE_FG_RED"

	# __segment_prompt_user (all)
	readonly POWERLINE_LOOK_PROMPT_USER="$POWERLINE_FG_BASE3"
	readonly POWERLINE_SBAF_PROMPT_USER=''

	# __segment_prompt_user (non-root user)
	# Combined with `POWERLINE_LOOK_USER` and `POWERLINE_SBAF_USER`.
	readonly POWERLINE_LOOK_PROMPT_USER_NORMAL="$POWERLINE_BG_GREEN"
	readonly POWERLINE_SBAF_PROMPT_USER_NORMAL="$POWERLINE_FG_GREEN"

	# __segment_prompt_user (root user)
	# Combined with `POWERLINE_LOOK_USER` and `POWERLINE_SBAF_USER`.
	readonly POWERLINE_LOOK_PROMPT_USER_ROOT="$POWERLINE_BG_ORANGE"
	readonly POWERLINE_SBAF_PROMPT_USER_ROOT="$POWERLINE_FG_ORANGE"

	# __segment_pwd
	readonly POWERLINE_LOOK_PWD="$POWERLINE_BG_BASE1$POWERLINE_FG_BASE3"
	readonly POWERLINE_SBAF_PWD="$POWERLINE_FG_BASE1"

	# __segment_git
	readonly POWERLINE_LOOK_GIT="$POWERLINE_BG_BLUE$POWERLINE_FG_BASE3"
	readonly POWERLINE_SBAF_GIT="$POWERLINE_FG_BLUE"


	############################################################################
	# Segments


	## __end_previous_segment {bg_as_fg}
	# End the previous segment.
	#
	# @param bg_as_fg The escape sequence to use to set the background of the
	# next segmemt as the foreground.
	__end_previous_segment() {
		if [ -n "$PS1" ]; then
			local symbol="$POWERLINE_SYMBOL_SEGMENT_END"
		else
			local symbol=" "
		fi
		echo -n "$POWERLINE_TERM_REVERSE_VIDEO$1$symbol$POWERLINE_TERM_SGR0"
	}

	## __segment_failure {exit_status}
	# Prints the exit status code of the last run command if that command has
	# failed.
	#
	# @param exit_status The exit status code of the last run command.
	__segment_failure() {
		[ "$1" != "0" ] \
			&& __end_previous_segment "$POWERLINE_SBAF_FAILURE" \
			&& echo -n "$POWERLINE_LOOK_FAILURE$POWERLINE_SYMBOL_FAILURE$1"
	}


	## __segment_chroot
	# Prints the content of the `debian_chroot` variable.
	#
	# Note: The name `debian_chroot` is just a convention. There is nothing
	# Debian-specific in the handling of this.
	__segment_chroot() {
		[ -n "$debian_chroot" ] \
			&& __end_previous_segment "$POWERLINE_SBAF_CHROOT" \
			&& echo -n "$POWERLINE_LOOK_CHROOT" \
			&& echo -n "$POWERLINE_SYMBOL_CHROOT$debian_chroot"
	}

	## __segment_user
	# Prints the user name and the hostname.
	__segment_user() {
		if [[ ${EUID} == 0 ]] ; then
			__end_previous_segment \
					"$POWERLINE_SBAF_USER$POWERLINE_SBAF_USER_ROOT"
			echo -n "$POWERLINE_LOOK_USER$POWERLINE_LOOK_USER_ROOT\h"
		else
			__end_previous_segment \
					"$POWERLINE_SBAF_USER$POWERLINE_SBAF_USER_NORMAL"
			echo -n "$POWERLINE_LOOK_USER$POWERLINE_LOOK_USER_NORMAL\u@\h"
		fi
	}

	## __segment_prompt_os [exit_status]
	# Prints a different symbol depending on the operating system.
	#
	# Use a different background color if the last run command failed.
	#
	# @param exit_status The exit status code of the last run command.
	__segment_prompt_os() {
		case "$(uname)" in
			Darwin)
				local ps_symbol=$POWERLINE_SYMBOL_OS_DARWIN
				;;
			Linux)
				local ps_symbol=$POWERLINE_SYMBOL_OS_LINUX
				;;
			*)
				local ps_symbol=$POWERLINE_SYMBOL_OS_OTHER
		esac
		local look="$POWERLINE_LOOK_PROMPT_OS"
		local sbaf="$POWERLINE_SBAF_PROMPT_OS"
		if [ "$1" == "0" ] || [ -z "$1" ]; then
			look+="$POWERLINE_LOOK_PROMPT_OS_OK"
			sbaf+="$POWERLINE_SBAF_PROMPT_OS_OK"
		else
			look+="$POWERLINE_LOOK_PROMPT_OS_FAILED"
			sbaf+="$POWERLINE_SBAF_PROMPT_OS_FAILED"
		fi
		__end_previous_segment "$sbaf"
		echo -n "$look$ps_symbol"
	}

	## __segment_prompt_user
	# Prints the standard Bash prompt character.
	#
	# Prints `#` for `root` and `$` for the other users.
	__segment_prompt_user() {
		local look="$POWERLINE_LOOK_PROMPT_USER"
		local sbaf="$POWERLINE_SBAF_PROMPT_USER"
		if [[ ${EUID} == 0 ]] ; then
			look+="$POWERLINE_LOOK_PROMPT_USER_ROOT"
			sbaf+="$POWERLINE_SBAF_PROMPT_USER_ROOT"
		else
			look+="$POWERLINE_LOOK_PROMPT_USER_NORMAL"
			sbaf+="$POWERLINE_SBAF_PROMPT_USER_NORMAL"
		fi
		__end_previous_segment "$sbaf"
		echo -n "$look"'\$'
	}

	## __segment_pwd [$shortening]
	# Prints the current working directory.
	#
	# @param $shortening Specifies how to shorten the path when the user is not
	# `root`.
	#
	# Available options:
	#
	# * `w` (default): Do not shorten the path.
	#
	# * `W`: Use the basename.
	#
	# * A decimal number: When the path is longer than the specified number,
	#   truncate the left of the path and put ellipsis(`…`). The only exception
	#   to this rule is when the basename is longer than the limit (minus 2).
	#   In this case, the basename is fully printed.
	#
	#   Note: The specified number **must** be greater than 2.
	#
	# In all the cases, the home directory’s path is replaced by `~`.
	__segment_pwd() {
		local pwd="$PWD"
		local i="${#HOME}"

		# 1. $HOME -> ~
		if [ "${pwd:0:i}" == "$HOME" ]; then
			if [ "${#pwd}" == "$i" ]; then
				pwd='~'
			elif [ "${pwd:i:1}" == '/' ]; then
				pwd='~'"${pwd:i}"
			fi
		fi

		# 2. $shortening
		if [[ ${EUID} != 0 ]] && [ -n "$1" ] && [ "$1" != 'w' ] ; then
			local length="${#pwd}"
			local basename=$(basename "$pwd")
			local basename_length="${#basename}"
			if [ "$1" == 'W' ] || ((basename_lenght > $1 - 2)); then
				pwd=basename
			elif ((length > $1)); then
				local left=$((length - basename_length - 1))
				for ((i = left - 1; i >= length - $1 + 1; i--)); do
					if [ "${pwd:i:1}" == '/' ]; then
						left="$i"
					fi
				done
				pwd="…${pwd:left}"
			fi
		fi

		__end_previous_segment "$POWERLINE_SBAF_PWD"
		echo -n "$POWERLINE_LOOK_PWD$pwd"
	}

	## __segment_git
	# Prints a summary of the Git repository status.
	__segment_git() {
		[ -x "$(which git)" ] || return	# git not found

		# Get current branch name or short SHA1 hash for detached head.
		local branch="$(git symbolic-ref --short HEAD 2>/dev/null \
				|| git describe --tags --always 2>/dev/null)"
		[ -n "$branch" ] || return	# git branch not found

		local status="$POWERLINE_SYMBOL_BRANCH$branch"

		# Do we have uncommited changes?
		[ -n "$(git status --porcelain)" ] && status+=" $POWERLINE_SYMBOL_DIRTY"

		# How many commits local branch is ahead/behind of remote?
		local aheadN="$(git rev-list @{u}.. | wc -l)"
		local behindN="$(git rev-list ..@{u} | wc -l)"
		[ "$aheadN" != "0" ] \
			&& status+=" $POWERLINE_SYMBOL_COMMITS_AHEAD$aheadN"
		[ "$behindN" != "0" ] \
			&& status+=" $POWERLINE_SYMBOL_COMMITS_BEHIND$behindN"

		__end_previous_segment "$POWERLINE_SBAF_GIT"
		echo -n "$POWERLINE_LOOK_GIT$status"
	}


	############################################################################
	# Prompt building

	## ps1
	# Called by the shell to build the prompt.
	ps1() {
		local status=$?

		# We MUST begin with an empty `PS1`.
		PS1=""

		# Insert segments here.
		# Each segment MUST be inserted separately.
		PS1+="$(__segment_failure "$status")"
		PS1+="$(__segment_chroot)"
		PS1+="$(__segment_user)"
		PS1+="$(__segment_pwd 32)"
		PS1+="$(__segment_git)"
		PS1+="$(__segment_prompt_user)"

		PS1+="$(__end_previous_segment "$POWERLINE_SBAF_DEFAULT")"
		PS1+="$POWERLINE_TERM_RESET_RENDITION"
	}

	PROMPT_COMMAND=ps1
}

__powerline
unset __powerline
