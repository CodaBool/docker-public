# Deprecated
I've wrote docker lines but have now moved to using the binary.

# Usage
## Manual
1. `cd some/sync/folder`
2. `rclone config`
3. `rclone bisync proton:/sync . --verbose --resync`
4. `rclone bisync proton:/sync . --verbose`

## Just script
1. `cd some/sync/folder`
2. `just config`
3. `just resync`
4. `just sync`

## crontab
```sh
*/5 * * * * cd /home/codabool/Documents && rclone bisync proton:/sync . --protondrive-replace-existing-draft --log-file /home/codabool/code/cron.log
0 0 * * * rm /home/codabool/code/rclone-cron.log
```
# Android
I have bisync enabled with Termux. I have a loose note of relevant commands for this:

```
pkg install termux-exec cronie termux-services termux-setup-storage
# restart termux session
sv-enable crond
crontab -e

*/5 * * * * cd /data/data/com.termux/files/home/storage/shared/protondrive && rclone bisync proton:/sync . --protondrive-replace-existing-draft --log-file /data/data/com.termux/files/home/cron.log
```

# Mount
> I found that mount worked for local changes but didn't pickup remote. So, I've moved away from this approach
```sh
rclone mount proton:/sync .. -v

# if does not unmount successfully will need to do so manually:
#   sudo umount -l /home/codabool/Documents
rclone mount proton:/sync /home/codabool/Documents -vv \
  --vfs-cache-mode full \
  --poll-interval=10s \
  --dir-cache-time=30s \
  --allow-non-empty \
  --vfs-read-ahead 128M \
  --buffer-size 256M
```
