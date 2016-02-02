FROM eeacms/plone-eea-www-devel
MAINTAINER "Alin Voinea" <alin.voinea@eaudeweb.ro>

ENV PLONE_APP_ASYNC multi_db_worker

USER root
RUN ./install.sh
RUN find . -name "*single_db_worker-configure.zcml" -exec rm -f {} \;
RUN find . -name "*db_instance-configure.zcml" -exec rm -f {} \;
RUN find . -name "*eea.plonebuildout.profile*.zcml" -exec rm -f {} \;
USER zope-www
