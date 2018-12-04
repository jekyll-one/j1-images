# ------------------------------------------------------------------------------
# ~/repos/j1image/Dockerfile
# J1 Development Image to create Docker Images for the J1 Project
# Based on Alpine Linux (https://alpinelinux.org/)
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

# BASE - Define base image Ruby|Alpine Linux
# ------------------------------------------------------------------------------
FROM ruby:alpine3.6

# SET - Author information
# ------------------------------------------------------------------------------
LABEL maintainer "Juergen Adams <juergen@jekyll-one.com>"

# COPY - Wrapper and helper scripts
# ------------------------------------------------------------------------------
COPY copy /

# RUBY - Export environment settings
# ------------------------------------------------------------------------------
ENV BUNDLE_HOME=/usr/local/bundle
ENV BUNDLE_APP_CONFIG=/usr/local/bundle
ENV BUNDLE_BIN=/usr/local/bundle/bin
ENV GEM_BIN=/usr/local/bin
ENV GEM_HOME=/usr/local/bundle

# DOCKER - Export environment settings
# ------------------------------------------------------------------------------
ENV DOCKER_SOCKET=/var/run/docker.sock

# IMAGE - Export environment settings
# ------------------------------------------------------------------------------
ENV J1_VAR_DIR=/var/j1
ENV J1_DOCKER_TAG=<%= @meta.tag %>
ENV J1_VERSION=<%= @meta.release?? @meta.release : @meta.tag %>
ENV J1_DOCKER_NAME=<%= @meta.name %>
ENV J1_DATA_DIR=/j1/data
ENV J1_BIN_DIR=/usr/j1/bin
ENV USR_BIN=/usr/bin
ENV LOCAL_BIN=/usr/local/bin
ENV DEBUG=false

# SYSTEM - Export environment settings
# ------------------------------------------------------------------------------
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV TZ=Europe/Berlin
ENV PATH="$J1_BIN_DIR:$PATH"
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US

# MAIN - Export environment settings
# ------------------------------------------------------------------------------
ENV VERBOSE=false
ENV FORCE_POLLING=false
ENV DRAFTS=false

# DEV - Install Development Libraries
# ------------------------------------------------------------------------------
RUN apk --no-cache add \
  zlib-dev \
  libxml2-dev \
  libxslt-dev \
  readline-dev \
  libffi-dev

# DEV - Install Development Applications
# ------------------------------------------------------------------------------
RUN apk --no-cache add build-base

# MAIN - Install Libraries
# ------------------------------------------------------------------------------
RUN apk --no-cache add \
  linux-headers \
  zlib \
  libxml2 \
  libxslt \
  libffi

# MAIN - Install Applications
# ------------------------------------------------------------------------------
RUN apk --no-cache add \
  bash \
  less \
  wget \
  curl \
  su-exec \
  git

# USER - Install User defined Packages
# ------------------------------------------------------------------------------
<% if @meta.packages? %>
  RUN apk --no-cache add <%= @meta.packages %>
<% end %>

# RUBYGEM - Disable RI|RDOC processing for all RubyGem
# ------------------------------------------------------------------------------
RUN echo "gem: --no-ri --no-rdoc" > ~/.gemrc

# RUBYGEM - Update
# ------------------------------------------------------------------------------
RUN yes | gem update --system

# RUBYGEM - Base Rubies
# ------------------------------------------------------------------------------
# Prevent vendored bundles to fail
# See: https://github.com/rubygems/rubygems/issues/2062
RUN gem install bundler

# RUBYGEM - Base User Rubies
# ------------------------------------------------------------------------------
<% if @meta.gems? %>
  # Use system-libraries for all RubyGem to speedup slow builts of Rubies
  # using native extensions (like Nokogiri)
  RUN gem install <%= @meta.gems %> -- --use-system-libraries
<% end %>

# Docker - Install Docker CLI, mount the socket, add j1 to docker group
# ------------------------------------------------------------------------------
# RUN apk --no-cache add docker

# SETUP - Set user and groups
# ------------------------------------------------------------------------------
RUN addgroup -Sg 1000 j1
RUN adduser  -Su 1000 -G j1 j1
#RUN addgroup -Sg 5555 cifs
#RUN usermod  -aG cifs j1
#RUN usermod -aG docker j1

# SETUP - Create Application folders
# ------------------------------------------------------------------------------
RUN mkdir -p $J1_VAR_DIR
RUN mkdir -p $J1_DATA_DIR
RUN chown -R j1:j1 $J1_DATA_DIR
RUN chown -R j1:j1 $J1_VAR_DIR
RUN chown -R j1:j1 $BUNDLE_HOME
RUN chown -R j1:j1 $BUNDLE_BIN
RUN chown -R j1:j1 $GEM_BIN
RUN chown -R j1:j1 $J1_BIN_DIR
RUN chmod -R ug+x $BUNDLE_BIN
RUN chmod -R ug+x $J1_BIN_DIR

# SETUP - Cleanup Application folders
# ------------------------------------------------------------------------------
RUN rm -rf $BUNDLE_HOME/cache
RUN rm -rf $GEM_HOME/cache

# RUN - Application startup
# ------------------------------------------------------------------------------
WORKDIR $J1_DATA_DIR
ENTRYPOINT ["/usr/j1/bin/entrypoint"]
CMD [ "su-exec", "j1", "irb" ]
