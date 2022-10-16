cd ~/.brave-bookmarks
./restore.sh

crontab -l > mycron
echo "0 */3 * * * cd ~/.brave-bookmarks && ./backup.sh check >/dev/null 2>&1" >> mycron
crontab mycron
rm mycron
