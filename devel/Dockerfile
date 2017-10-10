FROM eeacms/www

COPY docker-setup.sh /
COPY versions.cfg warmup.ini /plone/instance/
COPY tools/* /plone/instance/tools/
RUN /docker-setup.sh
