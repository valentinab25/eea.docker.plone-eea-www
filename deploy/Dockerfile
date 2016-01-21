FROM eeacms/plone-eea-common
MAINTAINER "Alin Voinea" <alin.voinea@eaudeweb.ro>

COPY src/sources.cfg                  $ZOPE_HOME/
COPY src/www.cfg                      $ZOPE_HOME/
COPY src/base.cfg                     $ZOPE_HOME/

ENV PLONE_APP_ASYNC                   multi_db_instance

ENV zope_i18n_compile_mo_files        false
ENV portal_url                        http://www.eea.europa.eu
ENV AOA_MAP_TILES                     http://aoa.ew.eea.europa.eu/maptiles/
ENV AOA_PORTAL_URL                    http://aoa.ew.eea.europa.eu/
ENV MEMCACHE_SERVER                   memcached:11211
ENV WKHTMLTOPDF_PATH                  wkhtmltopdf

ENV EEADOWNLOADS_NAME                 downloads
ENV EEADOWNLOADS_PATH                 /data/downloads/pdf
ENV EEACONVERTER_TEMP                 /data/downloads/tmp
ENV EEALOGINAGENT_LOG                 /data/eea.controlpanel
ENV EEACPBINSTANCESAGENT_LO           /data/eea.controlpanel
ENV saved_resources                   /data/www-static-resources

ENV TRACEVIEW_SAMPLE_RATE             1.0
ENV TRACEVIEW_DETAILED_PARTITION      1
ENV TRACEVIEW_TRACING_MODE            always

VOLUME                                /data

USER root

RUN \
  mkdir -p \
     /data/blobs \
     /data/www-static-resources \
     /data/downloads/pdf \
     /data/downloads/tmp \
     /data/eea.controlpanel && \
  chown -R 500:500 /data

COPY . /opt/app
RUN install-dependencies /opt/app
RUN ./install.sh

USER zope-www
