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
ADD code /rails/aaroseconstruction
# move the gems into the app 
RUN mv /tmp/.bundle /rails/aaroseconstruction
RUN mv /tmp/vendor/bundle /rails/aaroseconstruction/vendor
RUN mv /tmp/bin /rails/aaroseconstruction/bin
RUN mkdir -p /rails/aaroseconstruction/tmp/sockets
RUN chown -R rails:rails /rails/aaroseconstruction

ADD drunkship_files/application.yml /rails/aaroseconstruction/config/application.yml
ADD drunkship_files/interim_database.yml /rails/aaroseconstruction/config/database.yml
ADD drunkship_files/unicorn.rb /rails/aaroseconstruction/config/unicorn.rb

USER rails
WORKDIR /rails/aaroseconstruction
RUN bundle install --binstubs --deployment --without test development
RUN bundle exec rake assets:precompile
ADD drunkship_files/database.yml /rails/aaroseconstruction/config/database.yml

CMD bundle exec unicorn_rails -E production -c /rails/aaroseconstruction/config/unicorn.rb
