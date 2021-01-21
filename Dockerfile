ARG FROM_IMAGE

FROM ${FROM_IMAGE}

ADD ./public/ /srv/www
