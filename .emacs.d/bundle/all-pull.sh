#!/bin/bash

# WORK_DIR=$(dirname $0)
WORK_DIR=~/.emacs.d/bundle

PULL_DIRS=$(ls $WORK_DIR)

for PULL_DIR in $PULL_DIRS
do
    if [ -d $PULL_DIR ]
    then
        cd $PULL_DIR

        git pull

        cd $WORK_DIR
    fi
done
