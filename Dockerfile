FROM ruby:3.2.2

RUN apt update -qq \
    && apt install -y nodejs npm default-mysql-client \
    && rm -rf /var/lib/apt/lists/*
RUN npm install -g yarn

COPY Gemfile /ac_rails/Gemfile
COPY Gemfile.lock /ac_rails/Gemfile.lock
RUN bundle install

COPY . /ac_rails

WORKDIR /ac_rails
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
