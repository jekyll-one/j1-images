# ------------------------------------------------------------------------------
# ~/repos/j1base/Dockerfile
# J1 Docker Development Image based on Alpine Linux (https://alpinelinux.org/)
#
# Product/Info:
# https://jekyll-one.com
#
# Copyright (C) 2018 Juergen Adams
#
# J1 Template is licensed under the MIT License.
# See: https://github.com/jekyll-one/j1_template_mde/blob/master/LICENSE
# ------------------------------------------------------------------------------
# NOTE:
#
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# BASE - Define base image Ruby|Alpine Linux
# ------------------------------------------------------------------------------
FROM ruby:alpine3.7

# ------------------------------------------------------------------------------
# SET - Author information
# ------------------------------------------------------------------------------
LABEL maintainer "Juergen Adams <juergen@jekyll-one.com>"

# ------------------------------------------------------------------------------
# COPY - Wrapper and helper scripts
# ------------------------------------------------------------------------------
COPY copy /

# ------------------------------------------------------------------------------
# RUBY - Export environment settings
# ------------------------------------------------------------------------------
ENV BUNDLE_HOME=/usr/local/bundle
ENV BUNDLE_APP_CONFIG=/usr/local/bundle
ENV BUNDLE_BIN=/usr/local/bundle/bin
ENV GEM_BIN=/usr/gem/bin
ENV GEM_HOME=/usr/gem

# ------------------------------------------------------------------------------
# IMAGE - Export environment settings
# ------------------------------------------------------------------------------
ENV J1_VAR_DIR=/var/j1
ENV J1_DOCKER_TAG=<%= @meta.tag %>
ENV J1_VERSION=<%= @meta.release?? @meta.release : @meta.tag %>
ENV J1_DOCKER_COMMIT=<%= `git rev-parse --verify HEAD`.strip %>
ENV J1_DOCKER_NAME=<%= @meta.name %>
ENV J1_DATA_DIR=/j1/data
ENV J1_HOME=/usr/j1
ENV J1_BIN=/usr/j1/bin
ENV J1_ENV=development
ENV LOCAL_BIN=/usr/local/bin
ENV DEBUG=false

# ------------------------------------------------------------------------------
# SYSTEM - Export environment settings
# ------------------------------------------------------------------------------
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV TZ=Europe/Berlin
ENV PATH="$J1_BIN:$PATH"
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US

# ------------------------------------------------------------------------------
# MAIN - Export environment settings
# ------------------------------------------------------------------------------
ENV VERBOSE=false
ENV FORCE_POLLING=false
ENV DRAFTS=false
ENV J1DOCKER=true

# ------------------------------------------------------------------------------
# DEV - Install Development Libraries
# ------------------------------------------------------------------------------
RUN apk --no-cache add \
  zlib-dev \
  libxml2-dev \
  libxslt-dev \
  readline-dev \
  libffi-dev \
  yaml-dev

# ------------------------------------------------------------------------------
# DEV - Install Development Applications
# ------------------------------------------------------------------------------
RUN apk --no-cache add \
  build-base \
  cmake

# ------------------------------------------------------------------------------
# MAIN - Install Libraries
# ------------------------------------------------------------------------------
RUN apk --no-cache add \
  linux-headers \
  zlib \
  libxml2 \
  libxslt \
  libffi \
  libressl

# ------------------------------------------------------------------------------
# MAIN - Install Applications
# ------------------------------------------------------------------------------
RUN apk --no-cache add \
  mc \
  bash \
  less \
  readline \
  tzdata \
  shadow \
  su-exec \
  git

# ------------------------------------------------------------------------------
# LANGUAGE - Install NodeJS
# ------------------------------------------------------------------------------
RUN apk --no-cache add \
  nodejs \
  nodejs-npm \
  yarn \
  && yarn global add lerna

# ------------------------------------------------------------------------------
# LANGUAGE - Install Python
# ------------------------------------------------------------------------------
RUN apk add --update \
  python \
  python-dev \
  py-pip \
  build-base \
  && pip install --upgrade pip \
  && pip install virtualenv \
  && rm -rf /var/cache/apk/*

# ------------------------------------------------------------------------------
# USER - Install User defined Packages
# ------------------------------------------------------------------------------
<% if @meta.packages? %>
  RUN apk --no-cache add <%= @meta.packages %>
<% end %>

# ------------------------------------------------------------------------------
# RUBYGEM - Disable RI|RDOC processing for all RubyGem
# ------------------------------------------------------------------------------
RUN echo "gem: --no-ri --no-rdoc" > ~/.gemrc
RUN echo "gem: --no-ri --no-rdoc" > $J1_HOME/.gem

# ------------------------------------------------------------------------------
# RUBYGEM - Update
# ------------------------------------------------------------------------------
# RUN yes | gem update --system

# ------------------------------------------------------------------------------
# RUBYGEM - Base Ruby and Jekyll Rubies
# ------------------------------------------------------------------------------
# Prevent vendored bundles to fail.
# See: https://github.com/rubygems/rubygems/issues/2062
RUN gem install bundler
RUN gem install jekyll -v<%= @meta.release?? \
  @meta.release : @meta.tag %> -- --use-system-libraries

# ------------------------------------------------------------------------------
# RUBYGEM - Base User Rubies
# ------------------------------------------------------------------------------
<% if @meta.gems? %>
  # Use system-libraries for all RubyGem to speedup slow builts of Rubies
  # using native extensions (like Nokogiri)
  RUN gem install <%= @meta.gems %> -- --use-system-libraries
<% end %>

# ------------------------------------------------------------------------------
# SETUP - Set user and groups
# ------------------------------------------------------------------------------
RUN addgroup -Sg 1000 j1
RUN adduser  -Su 1000 -G j1 j1
RUN addgroup -Sg 5555 cifs
RUN usermod  -aG cifs j1

# ------------------------------------------------------------------------------
# SETUP - Create Application folders
# ------------------------------------------------------------------------------
RUN mkdir -p $J1_VAR_DIR
RUN mkdir -p $J1_DATA_DIR
RUN chown -R j1:j1 $J1_BIN
RUN chmod -R ug+x $J1_BIN
RUN chown -R j1:j1 $J1_DATA_DIR
RUN chown -R j1:j1 $J1_VAR_DIR
RUN chown -R j1:j1 $BUNDLE_HOME

# ------------------------------------------------------------------------------
# SETUP - Cleanup Application folders
# ------------------------------------------------------------------------------
RUN rm -rf $BUNDLE_HOME/cache
RUN rm -rf $GEM_HOME/cache


# ------------------------------------------------------------------------------
# Set the environment for the app
# ------------------------------------------------------------------------------
#VOLUME  /j1/data
WORKDIR $J1_DATA_DIR
CMD ["j1", "--help"]
ENTRYPOINT ["/usr/j1/bin/entrypoint"]

# ------------------------------------------------------------------------------
# JEKYLL - Expose base ports for Jekyll (WEBrick and Livereload)
# -------------------------------------------------------------------------
EXPOSE 35729
EXPOSE 40000

# ------------------------------------------------------------------------------
# PYTHON - Install all required libraries on NEXT build (e.g. j1:latest)
# ------------------------------------------------------------------------------
ONBUILD RUN virtualenv /env \
  && /env/bin/pip install -r /usr/python/requirements.txt

# ------------------------------------------------------------------------------
# RUBYGEM - Vendorize all System Rubies on NEXT build (e.g. j1:latest)
# ------------------------------------------------------------------------------
ONBUILD RUN chown -R j1:j1 $GEM_HOME
ONBUILD RUN ln -sf $GEM_HOME/* $BUNDLE_HOME
