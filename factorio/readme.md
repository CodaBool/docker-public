### Auto Update
There is a script which uses a factorio API to get the latest stable version. Then compare this to the current running container.

To run this script add this to your cron 

```
# auto update factorio container `crontab -e`
0 * * * * /hdd/dock/factorio/auto_update.sh
```
