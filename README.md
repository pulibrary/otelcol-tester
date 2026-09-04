### otelcol-tester

This is a quick-and-dirty setup to help debug questions about the otelcol-tester, for example:
* Is my filter working correctly?
* Is the log output/parsing working correctly?

#### To use:

To test whether a line will be logged by an otelcol filter:

1. `devbox shell`
1. Copy the otelcol config file you wish to test: `scp pulsys@lib-solr-prod3.princeton.edu:/opt/otelcol/config.yaml .`
1. `devbox run start`

In another terminal:
1. create a relative / local directory with the same path as the directory for the logfiles you want to test the parsing of, e.g. `mkdir -p solr/logs` or `mkdir -p var/log/nginx/`
1. Copy over a few logs into the directory you made:
    ```
    ssh deploy@lib-solr-prod3.princeton.edu 'tail -20 /solr/logs/solr_slow_requests.log' > ./solr/logs/solr_slow_requests.log
    ```
1. Check the results.json.  If you are just looking for log entry bodies, you can run `ruby check_log_bodies.rb`

#### To iterate:

1. Make a change to your config
1. `Ctrl + C` your otelcol
1. Repeat the steps above beginning from `devbox run start`
