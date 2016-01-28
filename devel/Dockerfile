FROM eeacms/plone-eea-www
MAINTAINER "Alin Voinea" <alin.voinea@eaudeweb.ro>

COPY src/base.cfg $ZOPE_HOME/

USER root
RUN ./install.sh
RUN find . -name "*single_db_instance-configure.zcml" -exec rm -f {} \;
RUN find . -name "*db_worker-configure.zcml" -exec rm -f {} \;
USER zope-www
