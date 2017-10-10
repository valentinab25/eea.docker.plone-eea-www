FROM eeacms/www

RUN ln -s /plone/instance/bin/mkrelease /usr/local/bin/mkrelease \
 && pip install docutils

COPY docker-setup.sh /
COPY versions.cfg warmup.ini /plone/instance/
COPY tools/* /plone/instance/tools/
RUN /docker-setup.sh
