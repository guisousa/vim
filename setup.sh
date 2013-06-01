#!/bin/bash

# Color Constants
black='\E[30;40m'                                                                                                                                                          
red='\E[31;40m'
green='\E[32;40m'
yellow='\E[33;40m'
blue='\E[34;40m'
magenta='\E[35;40m'
cyan='\E[36;40m'
white='\E[37;40m'
# Color Echo
function success()                                                                                                                                                           
{
    echo $'\e[32m'"$1"
    tput sgr0
}
function error()                                                                                                                                                           
{
    echo $'\e[31m'"$1"
    tput sgr0
}
# Detecting System
home='/home/'${USER}
platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
    platform='linux'
    home='/home/'${USER}
elif [[ "$unamestr" == 'Darwin' ]]; then
    platform='mac'
    home='/Users/'${USER}
fi

# Helper functions
function uninstall()
{
    rm -rf ${home}/.vim/pandemic-bundles
    rm -rf ${home}/.vim/bundle.remote
    for b in `pandemic list | column -t | cut -d ":" -f 1`; do
        pandemic remove $b
    done
}
function install()
{
    pandemic add xterm-color-table.vim  git  git://github.com/guns/xterm-color-table.vim.git
    pandemic add tabular                git  git://github.com/godlygeek/tabular.git
    pandemic add refactor               git  git://github.com/vim-scripts/refactor.git
    pandemic add vim-visual-star-search git  git://github.com/nelstrom/vim-visual-star-search.git
    pandemic add vim-unimpaired         git  git://github.com/tpope/vim-unimpaired.git
    tmp=`mktemp -u /tmp/tmp.XXXXX` && ruby -ne 'puts chomp'  ~/.vim/bundle.remote/refactor/plugin/refactor.vim > $tmp && mv $tmp ~/.vim/bundle.remote/refactor/plugin/refactor.vim
}
function update()
{
    pandemic update
    tmp=`mktemp -u /tmp/tmp.XXXXX` && ruby -ne 'puts chomp'  ~/.vim/bundle.remote/refactor/plugin/refactor.vim > $tmp && mv $tmp ~/.vim/bundle.remote/refactor/plugin/refactor.vim
}

# Install pandemic if necessary
pandemic=`pandemic -h 2> /dev/null 1> /dev/null;echo $?`
if [[ "$pandemic" -ne 0 ]]; then
    git clone git://github.com/jwcxz/vim-pandemic.git
    sudo python setup.py install
fi

# Copying files to right locations
success "--- Copying files ---"
cp -v ${home}/.vimrc .old_vimrc
cp -v vimrc ${home}/.vimrc
if [[ "$1" == "-update" ]]; then
    success "--- Updating Plugins ---"
    update
else
    success "--- Uninstalling Plugins ---"
    uninstall
    success "--- Installing Plugins ---"
    install
fi
if [[ ${platform} == 'linux' ]]; then
    scp -r ${home}/.vimrc chaiten.jda.local:
    scp -r ${home}/.vim   chaiten.jda.local:
fi
success "--- Setup Done ---"

