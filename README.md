# EEA Plone WWW Docker Image based on EEA KGS 

Docker Plone Image used for EEA website. See more at [eea.docker.www](https://github.com/eea/eea.docker.www)

## Release new versions of this image

Get source code

    $ git clone git@github.com:eea/eea.docker.plone-eea-www.git

Update `FROM eeacms/kgs:X.Y` base image within `Dockerfile`

    $ cd eea.docker.kgs
    $ vim Dockerfile
    FROM eeacms/kgs:19.5

Commit changes

    $ git commit -a "Release 19.5"

Create tag

    $ git tag 19.5

Push changes

    $ git push
    $ git push --tags
