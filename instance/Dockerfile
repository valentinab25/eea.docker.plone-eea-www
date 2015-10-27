FROM eeacms/plone-eea-common-relstorage
MAINTAINER "Alin Voinea" <alin.voinea@eaudeweb.ro>

ENV PLONE_APP_ASYNC multi_db_instance

COPY src/sources.cfg   $ZOPE_HOME/
COPY src/www.cfg       $ZOPE_HOME/
COPY src/base.cfg      $ZOPE_HOME/

RUN ./install.sh
