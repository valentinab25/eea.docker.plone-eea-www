FROM eeacms/www

RUN mv devel.cfg base-devel.cfg \
 && ln -s /plone/instance/bin/mkrelease /usr/local/bin/mkrelease \
 && pip install docutils

COPY docker-setup.sh /
COPY versions.cfg devel.cfg warmup.ini /plone/instance/
COPY tools/* /plone/instance/tools/
RUN /docker-setup.sh
