#!/usr/bin/env bash

BOOKMARKS_PATH=~/.config/BraveSoftware/Brave-Browser/Default/Bookmarks
SUBMODULE=bookmarks
SECONDS_IN_A_DAY=86400

suffix=`date +%m%d%y_%H%M%S`
fileName=Bookmarks_${suffix}.json
backupFilePath=$SUBMODULE/$fileName
runType=force

copyBookmarks() {
    cp $BOOKMARKS_PATH $backupFilePath
}

checkMtime() {
    bookmarkTime=`stat -c %Y $BOOKMARKS_PATH`
    currentTime=`date +%s`
    timeDifference=`expr $currentTime - $bookmarkTime`
 
    if [ $timeDifference -lt $SECONDS_IN_A_DAY ]; then
        copyBookmarks
    fi
}

pushBackup() {
    commitMessage="Backup: `date "+%b %d, %Y"`"

    cd $SUBMODULE
    git checkout main
    git add $fileName
    git commit -m "$commitMessage"
    git push
    cd ..
    git add $SUBMODULE
    git commit -m "$commitMessage"
    git push
}

usage() {
    echo "usage: backup [run-type]"
    echo "    run-type: force, day (default: force)"
}

if [ "$#" -gt 1 ]; then
    echo "error: to many peremeters"
    usage
    exit 1
fi

if [ -n "$1" ]; then
    runType=$1
fi

if [ $runType == "force" ]; then
    copyBookmarks
elif [ $runType == "day" ]; then
    checkMtime
else
    echo "error: invalid run-type: $runType"
    usage
    exit 1
fi

pushBackup

