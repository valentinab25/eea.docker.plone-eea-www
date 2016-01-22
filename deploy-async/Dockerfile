FROM eeacms/plone-eea-www
MAINTAINER "Alin Voinea" <alin.voinea@eaudeweb.ro>

ENV PLONE_APP_ASYNC multi_db_worker

USER root
RUN rm -rf $ZOPE_HOME/parts
RUN ./install.sh
USER zope-www
