FROM docker:dind
#install curl
RUN apk add --no-cache curl && apk add -y --no-cache bash
ADD script.sh /tmp/script.sh
RUN chmod +x /tmp/script.sh
ENTRYPOINT /tmp/script.sh