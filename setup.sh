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
    ~/.vim/update_bundles
    tmp=`mktemp -u /tmp/tmp.XXXXX` && ruby -ne 'puts chomp'  ~/.vim/bundle/refactor/plugin/refactor.vim > $tmp && mv $tmp ~/.vim/bundle/refactor/plugin/refactor.vim
}

# Copying files to right locations
success "--- Copying files ---"
cp -v update_bundles ${home}/.vim/
cp -v vimrc ${home}/.vimrc
success "--- Updating Plugins ---"
update
success "--- Setup Done ---"

