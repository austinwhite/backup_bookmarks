# backup_bookmarks
Creates bookmark backups for the 'Brave' web browser.

## Setup
### basic steps
1. fork the repository
2. create a private github repo named 'bookmarks'
3. remove the existing 'bookmarks' submodule
4. delete the existing submodule entry in the .gitmodules file
5. add your private bookmarks repos as a submodule: ```git submodule add [private repo url]```
6. enable submodule recurse in yor git config: ```git config --global submodule.recurse true```

Each time you clone your repo you'll need to re-initialize the submodule: <br/>
```cd bookmarks``` <br/>
```git submodule init``` <br/>
```git submodule update``` <br/>

or clone with the ```--recurse``` flag (enabling recurse in your gitconfig doesn't work for cloning).

### automation
* In order to automate the script, you'll need your git credentials persitently stored. Use your method of choice.<br/>
* Create a cron job to run the backup script using the frequency of your choice.

## Usage
```backup [run-type]```

run-type
* force (default): creates a backup file regardless of last modification date of 'Bookmarks' file
* day: creates a backup only if 'Bookmarks' has been updated in the last 24 hours
