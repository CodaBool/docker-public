# 🖥️ Self Host w/ Docker

## Start
go into any folder and run a `docker-compose up -d` to start a service

## Login
Most require logging in with a browser and completing a initial set up.

If there is any confusion usually the docker image's page will have additional details.

## Folders
Most services can have a local data or config folder. But a few services share data and expect a /hdd folder mounted. Additionally they expect the following pattern for media, downloads and syncing

```
/hdd/media/movies
/hdd/media/tv
/hdd/downloads
/hdd/sync
```