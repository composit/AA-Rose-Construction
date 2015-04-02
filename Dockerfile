FROM ubuntu:14.04

Maintainer Matthew Rose

RUN apt-get update

# Install Ruby
RUN apt-get install -y ruby ruby1.9.1-dev build-essential

RUN gem install bundler

# development dependencies
RUN apt-get install -y sqlite3 libsqlite3-dev # sqlite

# bundle gems
ADD code/Gemfile /tmp/Gemfile
ADD code/Gemfile.lock /tmp/Gemfile.lock
WORKDIR /tmp
RUN bundle install --binstubs --deployment --without test development

ADD code /rails/aarose

# move the gems into the app 
RUN mv /tmp/.bundle /rails/aarose
RUN mv /tmp/vendor/bundle /rails/aarose/vendor
RUN mv /tmp/bin /rails/aarose/bin
RUN mkdir -p /rails/aarose/tmp/sockets
RUN mkdir -p /rails/aarose/log

ADD drunkship_files/application.yml /rails/aarose/config/application.yml
ADD drunkship_files/database.yml /rails/aarose/config/database.yml
ADD drunkship_files/unicorn.rb /rails/aarose/config/unicorn.rb

WORKDIR /rails/aarose

CMD bundle exec unicorn_rails -E production -c /rails/aarose/config/unicorn.rb
