#!/usr/bin/env bash

BOOKMARKS_PATH=~/.config/BraveSoftware/Brave-Browser/Default/Bookmarks
SUBMODULE=bookmarks
SECONDS_IN_A_DAY=86400

suffix=`date +%m%d%y_%H%M%S`
fileName=Bookmarks_${suffix}.json
backupFilePath=$SUBMODULE/$fileName
md5CheckSum=lastbackup
runType=check

copyBookmarks() {
    cp $BOOKMARKS_PATH $backupFilePath
}

validateCheckSum() {
    if [ -f "$md5CheckSum" ]; then
        md5sum -c $md5CheckSum
        if [ $? -ne 0 ]; then
            md5sum $BOOKMARKS_PATH > $md5CheckSum
        else
            return 1
        fi
    else
        md5sum $BOOKMARKS_PATH > $md5CheckSum
    fi

    return 0
}

checkLastBackup() {
    validateCheckSum
    if [ $? -ne 0 ]; then
        exit 1
    fi

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
    echo "    run-type: force, check (default: check)"
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
elif [ $runType == "check" ]; then
    checkLastBackup
else
    echo "error: invalid run-type: $runType"
    usage
    exit 1
fi

pushBackup

