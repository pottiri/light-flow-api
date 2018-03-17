FROM ruby:2.5.0-slim-stretch
RUN apt-get update -qq && apt-get install -y build-essential nodejs default-libmysqlclient-dev mysql-client
RUN mkdir /light-flow-api
WORKDIR /light-flow-api
COPY Gemfile /light-flow-api/Gemfile
COPY Gemfile.lock /light-flow-api/Gemfile.lock
RUN bundle install
COPY . /light-flow-api
