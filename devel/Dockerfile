FROM eeacms/plone-eea-www
MAINTAINER "Alin Voinea" <alin.voinea@eaudeweb.ro>

COPY src/base.cfg $ZOPE_HOME/

USER root
RUN ./install.sh
USER zope-www
