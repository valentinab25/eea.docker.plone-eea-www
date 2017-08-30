FROM eeacms/www

RUN mv devel.cfg base-devel.cfg
COPY docker-setup.sh /
COPY devel.cfg /plone/instance/
COPY warmup.ini /plone/instance/
COPY tools/* /plone/instance/tools/
RUN /docker-setup.sh
