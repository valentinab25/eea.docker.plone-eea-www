FROM eeacms/www

RUN mv devel.cfg base-devel.cfg \
 && ln -s bin/mkrelease /usr/local/bin/mkrelease

COPY docker-setup.sh /
COPY devel.cfg debug.sh warmup.ini /plone/instance/
COPY tools/* /plone/instance/tools/
RUN /docker-setup.sh
