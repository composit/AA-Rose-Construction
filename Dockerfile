FROM ubuntu:14.04

Maintainer Matthew Rose

RUN apt-get update

# Install Ruby
RUN apt-get install -y ruby ruby1.9.1-dev build-essential

RUN gem install bundler

# ADD a user
RUN adduser --disabled-password --home=/rails --gecos "" rails

# development dependencies
RUN apt-get install -y sqlite3 libsqlite3-dev # sqlite

RUN chown -R rails:rails /tmp

# bundle gems
ADD code/Gemfile /tmp/Gemfile
ADD code/Gemfile.lock /tmp/Gemfile.lock
USER rails
WORKDIR /tmp
RUN bundle install --binstubs --deployment --without test development

USER root
ADD code /rails/aarose
# move the gems into the app 
RUN mv /tmp/.bundle /rails/aarose
RUN mv /tmp/vendor/bundle /rails/aarose/vendor
RUN mv /tmp/bin /rails/aarose/bin
# This may be necessary outside of Kubernetes?
#RUN mkdir -p /rails/aarose/tmp/sockets
RUN mkdir -p /rails/aarose/log
RUN chown -R rails:rails /rails/aarose

ADD drunkship_files/application.yml /rails/aarose/config/application.yml
ADD drunkship_files/database.yml /rails/aarose/config/database.yml
ADD drunkship_files/unicorn.rb /rails/aarose/config/unicorn.rb

USER rails
WORKDIR /rails/aarose
RUN bundle install --binstubs --deployment --without test development

CMD bundle exec unicorn_rails -E production -c /rails/aarose/config/unicorn.rb

