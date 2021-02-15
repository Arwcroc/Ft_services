FROM alpine

RUN apk update
RUN apk add grafana --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --no-cache

ADD ./grafana.ini /usr/share/grafana/conf/grafana.ini
ADD ./dadashboards.yaml /usr/share/grafana/conf/provisioning/dashboards/dadashboards.yaml
ADD ./influx.yaml /usr/share/grafana/conf/provisioning/datasources/influx.yaml
ADD ./dockerdadash.json /dockerdadash.json

EXPOSE 3000

CMD grafana-server -homepath="/usr/share/grafana/" -config="/usr/share/grafana/conf/grafana.ini"