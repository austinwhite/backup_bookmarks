#!/bin/bash

BOOKMARKS_PATH=~/.config/BraveSoftware/Brave-Browser/Default/Bookmarks
SUBMODULE=bookmarks

lastBackup=$(ls -s bookmarks | grep Bookmarks | tail -1 | awk -F ' ' '{print $2}')

cp -f $SUBMODULE/$lastBackup $BOOKMARKS_PATH 
echo "copied $SUBMODULE/$lastBackup to $BOOKMARKS_PATH"
