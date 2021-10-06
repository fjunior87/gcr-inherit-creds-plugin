FROM google/cloud-sdk:alpine

ADD script.sh /tmp/script.sh
RUN chmod +x /tmp/script.sh
ENTRYPOINT /tmp/script.sh
