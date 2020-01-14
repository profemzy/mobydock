FROM python:3.8.1-slim-buster as app
MAINTAINER Femi Oladele <profemzy@gmail.com>

WORKDIR /app

COPY requirements.txt requirements.txt

ENV BUILD_DEPS="build-essential" \
    APP_DEPS="curl libpq-dev"

RUN apt-get update \
  && apt-get install -y ${BUILD_DEPS} ${APP_DEPS} --no-install-recommends \
  && pip install -r requirements.txt \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /usr/share/doc && rm -rf /usr/share/man \
  && apt-get purge -y --auto-remove ${BUILD_DEPS} \
  && apt-get clean

ARG FLASK_ENV="production"
ENV FLASK_ENV="${FLASK_ENV}" \
    FLASK_APP="mobydock.app" \
    PYTHONUNBUFFERED="true"

RUN pip install -r requirements.txt

COPY . .

VOLUME ["static"]

EXPOSE 8000

CMD gunicorn -b 0.0.0.0:8000 "mobydock.app:create_app()"
