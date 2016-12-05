FROM eeacms/www
MAINTAINER "EEA: IDM2 A-Team" <eea-edw-a-team-alerts@googlegroups.com>

RUN mv devel.cfg base-devel.cfg
COPY docker-setup.sh /
COPY devel.cfg /plone/instance/
RUN /docker-setup.sh
