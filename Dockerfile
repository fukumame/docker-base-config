FROM ruby:2.4.2
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main" >> /etc/apt/sources.list.d/pgdg.list && \
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
  apt-get update -qq && \
  curl -sL https://deb.nodesource.com/setup_4.x | bash - && \
  apt-get install -y nodejs postgresql-client-9.4; \
  apt-get update -qq && \
  apt-get install -y build-essential chrpath libssl-dev libxft-dev && \
  apt-get install -y libfreetype6 libfreetype6-dev && \
  apt-get install -y libfontconfig1 libfontconfig1-dev; \
  npm cache clean && \
  npm install -g yarn && \
  npm install -g n && \
  n stable && \
  ln -sf /usr/local/bin/node /usr/bin/node && \
  apt-get purge -y nodejs; \
  echo 'alias be="bundle exec"' >> ~/.bashrc; \
  echo " \n\
  if defined?(PryByebug) \n\
    Pry.commands.alias_command 's', 'step' \n\
    Pry.commands.alias_command 'n', 'next' \n\
    Pry.commands.alias_command 'f', 'finish' \n\
    Pry.commands.alias_command 'c', 'continue' \n\
  end" >> ~/.pryrc

ENV BUNDLE_PATH=/usr/local/bundle \
  BUNDLE_JOBS=4 \
  RAILS_LOG_TO_STDOUT=enabled \
  RAILS_SERVE_STATIC_FILES=enabled \
  LANG=C.UTF-8 \
  LC_ALL=C.UTF-8

WORKDIR app
#CMD ["bin/rails", "server", "-b", "0.0.0.0", "-p", "80"]

