docker run -p 9880:9880 \
    --rm \
    --name fluentd1 \
    -v $(pwd)/tmp:/fluentd/etc \
    fluent/fluentd:edge-debian \
    -c /fluentd/etc/fluentd.conf

