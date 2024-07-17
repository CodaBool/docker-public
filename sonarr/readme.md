# Extra trackers
> qbittorrent allows for extra trackers to be added onto torrents which greatly improves speed and can usually 100x your seeders

The trackers are often changing so the best solution is to get them dynamically. This script uses curl, jq and authentication with your qbittorrent container.
It will use the following four lists which are updated often:

- https://newtrackon.com/api/stable (updated every 2 minutes - 3 hours)
- https://trackerslist.com/best.txt (updated daily)
- https://trackerslist.com/http.txt (updated daily)
- https://raw.githubusercontent.com/ngosang/trackerslist/master/trackers_best.txt (updated daily)

> The longer the list the more trackers need to be reached out to
> I've found that picking either https://newtrackon.com/api/stable or https://trackerslist.com/best.txt is the best strategy
> I still get thousands of seeders while still having torrents begin their download in less than a minute
> So, I'd recommend removing all but one of these two lists. Unless you often download obscure torrents.

To use this start the container, then in the local config folder that gets created.
Create a new file by any name, give it execute permissions.
Fill the script with these lines:

https://raw.githubusercontent.com/Jorman/Scripts/master/AddqBittorrentTrackers.sh

Edit the first CONFIGURATIONS section to use your qbit host and login.
Edit down the four tracker lists (also found in the first CONFIGURATIONS block) mentioned above to just "https://newtrackon.com/api/stable" for extra speed.
Then in the application go to Settings > Connect > Custom Script

- uncheck everything but "On Grab"
- set the path to your script in /config/yourScriptHere.sh



