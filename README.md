# bash-powerline

Powerline-style Bash prompt in pure Bash script.

This a fork of [riobard/bash-powerline](https://github.com/riobard/bash-powerline)
that includes improvements from other forks.

## Features

* Git branch: display current git branch name, or short SHA1 hash when the head
  is detached
* Git branch: display "+" symbol when current branch is changed but uncommited
* Git branch: display "⇡" symbol and the difference in the number of commits when the current branch is ahead of remote
* Git branch: display "⇣" symbol and the difference in the number of commits when the current branch is behind of remote
* Status code for the previously failed command
* Fast execution (no noticable delay)
* No need for patched fonts


## Installation

Download the Bash script

    curl https://raw.github.com/jcbrinfo/bash-powerline/master/bash-powerline.sh > ~/.bash-powerline.sh

And source it in your `.bashrc`

    . "$HOME/.bash-powerline.sh"

For best result, use [Solarized
colorscheme](https://github.com/altercation/solarized) for your terminal
emulator. Or hack your own colorscheme by modifying the script. It's really
easy.


## Why?

Because we should not need a Python interpreter and a patched font to display
a poweline-style Bash prompt.


## See also
* [powerline](https://github.com/Lokaltog/powerline): Unified Powerline
  written in Python. This is the future of all Powerline derivatives. 
* [vim-powerline](https://github.com/Lokaltog/vim-powerline): Powerline in Vim
  writtien in pure Vimscript. Deprecated.
* [tmux-powerline](https://github.com/erikw/tmux-powerline): Powerline for Tmux
  written in Bash script. Deprecated.
* [powerline-shell](https://github.com/milkbikis/powerline-shell): Powerline for
  Bash/Zsh/Fish implemented in Python. Might be merged into the unified
  Powerline. 
* [emacs powerline](https://github.com/milkypostman/powerline): Powerline for
  Emacs
