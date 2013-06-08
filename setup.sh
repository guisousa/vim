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
function update()
{
    vim -c 'BundleInstall!'
    tmp=`mktemp -u /tmp/tmp.XXXXX` && ruby -ne 'puts chomp'  ~/.vim/bundle/refactor/plugin/refactor.vim > $tmp && mv $tmp ~/.vim/bundle/refactor/plugin/refactor.vim
}


# Copying files to right locations
success "--- Copying files ---"
cp -v ${home}/.vimrc .old_vimrc
cp -v vimrc ${home}/.vimrc
mkdir -v -p ${home}/.vim
cp -v java-colors.vim ${home}/.vim/
cp -v cpp-colors.vim ${home}/.vim/
cp -v vim-colors.vim ${home}/.vim/
mkdir -v -p ${home}/.vim/after/syntax
cp -v cpp.vim ${home}/.vim/after/syntax/
cp -v java.vim ${home}/.vim/after/syntax/

# Install Vundle if necessary
bundle=`ls ${home}/.vim/bundle/vundle 2> /dev/null 1> /dev/null;echo $?`
if [[ "$bundle" -ne 0 ]]; then
    success "--- Installing Plugin Manager ---"
    mkdir -p ${home}/.vim/bundle
    git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
    vim -c 'BundleInstall'
    tmp=`mktemp -u /tmp/tmp.XXXXX` && ruby -ne 'puts chomp'  ~/.vim/bundle/refactor/plugin/refactor.vim > $tmp && mv $tmp ~/.vim/bundle/refactor/plugin/refactor.vim
else
    success "--- Updating Plugins ---"
    update
fi
success "--- Setup Done ---"


