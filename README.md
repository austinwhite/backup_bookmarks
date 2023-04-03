# backup_bookmarks
Creates bookmark backups for the 'Brave' web browser.

## Setup
### Manual
1. fork the repository
2. create a private github repo named 'bookmarks'
3. remove the existing 'bookmarks' submodule
4. delete the existing submodule entry in the .gitmodules file
5. add your private bookmarks repos as a submodule: ```git submodule add [private repo url]```
6. enable submodule recurse in your git config: ```git config --global submodule.recurse true```

clone the repo to your home directoy with the name ```.brave-bookmarks```

```bash
git clone https://github.com/austinwhite/brave-broswer-backup-bookmarks-file ~/.brave-bookmarks
```

Each time you clone your repo you'll need to re-initialize the submodule.
```bash
cd bookmarks
git submodule init
git submodule update
```

or clone with the ```--recurse``` flag (enabling recurse in your gitconfig doesn't work for cloning).

Add a cron job to check for bookmark changes
```bash
crontab -l > mycron
echo "0 */3 * * * cd ~/.brave-bookmarks && ./backup check >/dev/null 2>&1" >> mycron
crontab mycron
rm mycron
```

### Automated
```bash
git clone https://github.com/austinwhite/brave-broswer-backup-bookmarks-file ~/.brave-bookmarks
cd ~/.brave-bookmarks
setup
``````

### Note
* In order to automate the script, you'll need your git credentials persitently stored. Use your method of choice.<br/>

## Usage
### Setup


### Creating backups
```bash
./backup [run-type]
``````

run-type
* force: forces the creates of a bookmark backup 
* check (default): creates a backup only if 'Bookmarks' has been modified since last backup 

### restoring bookmarks from backup
```bash
./restore
```

Gets the most recent backup and copies it to the brave bookmarks location on your system.
