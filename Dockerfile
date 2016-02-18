FROM alpine:3.3

COPY . /srv/
WORKDIR /srv

RUN apk update \
    && apk upgrade \
    && apk add \
        python \
        py-pillow \
    && apk add --virtual build-dependencies \
        python-dev \
        py-pip \
    && pip install -U pip \
    && pip install -r requirements.txt \
    && apk del build-dependencies \
    && rm -rf /var/cache/apk/* \
    && rm -rf /root/.cache

EXPOSE 8000
CMD ['python', 'manage.py', 'runserver', '0.0.0.0:8000']
