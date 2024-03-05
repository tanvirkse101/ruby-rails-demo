FROM ruby:3.2.0

RUN apt-get update -qq \
  && apt-get install -y --fix-missing \
  nodejs \
  yarnpkg \
  graphicsmagick \
  git \
  vim

RUN ln -s /usr/bin/yarnpkg /usr/bin/yarn
RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY . /app

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
CMD ["entrypoint.sh"]
EXPOSE 3000