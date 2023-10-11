FROM ruby:3.2.0

RUN apt-get update -qq && \
  apt-get install -y nodejs yarnpkg graphicsmagick git vim && \
  ln -s /usr/bin/yarnpkg /usr/bin/yarn && \
  mkdir /app

WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY . /app

# Copy the entrypoint.sh script to /usr/bin/ and make it executable
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

EXPOSE 3000

CMD ["entrypoint.sh"]