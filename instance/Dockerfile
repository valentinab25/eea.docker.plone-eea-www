FROM eeacms/plone-eea-common
MAINTAINER "Alin Voinea" <alin.voinea@eaudeweb.ro>

COPY src/www.cfg    $ZOPE_HOME/
COPY src/base.cfg   $ZOPE_HOME/

RUN ./install.sh
