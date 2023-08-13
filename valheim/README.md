# Logs
> WARNING

This container will generate log files quickly. 

After around a month of running it made 855GB of logs and stopped my other services.

This should be paired with a cron job to remove log files.


I don't know exactly which directory should be cleared but this could be found with the following commands:

> it was a .log file and should show with this
- `find . -type f -name "*.log" -size +50M | sort -n`

> This is a more general search of a directory for large files
- `find . -type f -size +50M -exec du -h {} \; | sort -n`

There are also additional filters which could be applied through environment variables found [here](https://hub.docker.com/r/lloesche/valheim-server#log-filters)