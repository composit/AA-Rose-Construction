FROM ruby:1.9.3-slim

Maintainer Matthew Rose

RUN apt-get update

# development dependencies
RUN apt-get install -y build-essential sqlite3 libsqlite3-dev

# bundle gems
ADD Gemfile /tmp/Gemfile
ADD Gemfile.lock /tmp/Gemfile.lock
WORKDIR /tmp
RUN bundle install

ADD . /rails/aarose
WORKDIR /rails/aarose

CMD bundle exec unicorn_rails -E production -c /rails/aarose/config/unicorn.rb
