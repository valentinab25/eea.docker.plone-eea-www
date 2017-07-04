FROM eeacms/kgs:11.5
ENV portal_url=https://www.eea.europa.eu \
    AOA_MAP_TILES=http://aoa.ew.eea.europa.eu/maptiles/ \
    AOA_PORTAL_URL=http://aoa.ew.eea.europa.eu/ \
    EEALOGINAGENT_LOG=/data/eea.controlpanel \
    EEACPBINSTANCESAGENT_LOG=/data/eea.controlpanel \
    RABBITMQ_HOST=rabbitmq \
    RABBITMQ_PORT=5672 \
    RABBITMQ_USER=guest \
    RABBITMQ_PASS=guest \
    saved_resources=/data/www-static-resources \
    zope_i18n_compile_mo_files=true \
    TRACEVIEW_SAMPLE_RATE=1.0 \
    TRACEVIEW_DETAILED_PARTITION=1 \
    TRACEVIEW_TRACING_MODE=always \
    WARMUP_BIN=/plone/instance/bin/warmup \
    WARMUP_INI=/plone/instance/warmup.ini \
    WARMUP_HEALTH_THRESHOLD=50000 \
    EDW_LOGGER_PUBLISHER=false

COPY src/* /plone/instance/
COPY docker-setup.sh traceview-setup.sh docker-entrypoint.sh /
RUN /docker-setup.sh && /traceview-setup.sh
