# GoGS Container

Go GIT Server.

Run it like the example below:

    $ docker run -d\
      -p 3000:3000\
      -v /mnt/docker-volumes/gogs-repository:/repository\
      -v /mnt/docker-volumes/gogs-data:/data\
      -v /mnt/docker-volumes/gogs-static:/static\
      --link gogs-postgres:postgres\
      ghmap/armhf-gogs

It expects a postgres container to be linked, an example command line for that would be:

    $ docker run --name gogs-postgres -d\
      -e POSTGRES_USER=gogs\
      -e POSTGRES_PASSWORD=<PWD>\
      -v /mnt/docker-volumes/gogs-pgdata:/var/lib/postgresql/data\
      zsoltm/postgresql-armhf

## Volumes

 + `/static` - static WEB assets and templates.
 + `/data` - various runtime data; logs, avatars and attachments
 + `/repository` - git repositories
