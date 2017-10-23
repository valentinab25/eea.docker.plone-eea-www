FROM eeacms/www

ENV SENTRY_DSN=https://52bee1ebb7d8494b899d066345856517@sentry.io/218533
COPY docker-setup.sh /
COPY versions.cfg warmup.ini /plone/instance/
COPY tools/* /plone/instance/tools/
RUN /docker-setup.sh
