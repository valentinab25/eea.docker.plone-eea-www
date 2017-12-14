FROM eeacms/www

COPY warmup.ini /plone/instance/
RUN chown plone:plone /plone/instance/warmup.ini \
 && apt-get update \
 && apt-get install -y --no-install-recommends build-essential \
 && rm -vrf /var/lib/apt/lists/* \
 && rm -vrf /plone/buildout-cache/downloads/* \
 && gosu plone buildout -c devel.cfg
