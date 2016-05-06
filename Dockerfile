FROM eeacms/kgs:6.6
MAINTAINER "EEA: IDM2 A-Team" <eea-edw-a-team-alerts@googlegroups.com>

ENV portal_url=http://www.eea.europa.eu \
    AOA_MAP_TILES=http://aoa.ew.eea.europa.eu/maptiles/ \
    AOA_PORTAL_URL=http://aoa.ew.eea.europa.eu/ \
    EEALOGINAGENT_LOG=/data/eea.controlpanel \
    EEACPBINSTANCESAGENT_LOG=/data/eea.controlpanel \
    saved_resources=/data/www-static-resources \
    TRACEVIEW_SAMPLE_RATE=1.0 \
    TRACEVIEW_DETAILED_PARTITION=1 \
    TRACEVIEW_TRACING_MODE=always

COPY docker-setup.sh /
COPY src/* /plone/instance/

USER root
RUN /docker-setup.sh
USER plone

VOLUME /data/www-static-resources /data/eea.controlpanel
