# backup_bookmarks
Creates backups of your bookmarks. Supports Debian based linux machines using the brave web browser. Can be easily modifed to support other system configurations.

## Setup
### basic steps
1. fork the repository
2. create a private reposity named 'bookmarks'
3. remove the existing 'bookmarks' submodule
4. delete the existing submodule entry in the .gitmodules file
5. add your private bookmarks repos as a submodule: ```git submodule add [private repo url]```

when you clone your repo, you need to re initialize your submodule: <br/>
```cd bookmarks``` <br/>
```git submodule init``` <br/>
```git submodule update``` <br/>

### automation
* In order to automate the script, you'll need your git credentials persitently stored. Use your method of coice.<br/>
* Create a cron job to run the backup script using the frequency of your choice.

## Usage
```backup [run-type]```

run-type
* force (default): creates a backup file regardless of last modification date of 'Bookmarks' file
* day: creates a backup only if 'Bookmarks' has been updated in the last 24 hours
