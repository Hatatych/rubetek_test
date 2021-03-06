FROM ruby:2.6.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /rubetek_test
WORKDIR /rubetek_test
COPY Gemfile /rubetek_test/Gemfile
COPY Gemfile.lock /rubetek_test/Gemfile.lock
RUN gem install bundler:2.0.2
RUN bundle install
COPY . /rubetek_test

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
