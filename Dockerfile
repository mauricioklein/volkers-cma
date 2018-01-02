FROM rails

ENV APP_PATH /app

RUN mkdir -p $APP_PATH
WORKDIR $APP_PATH

ADD Gemfile* $APP_PATH/

RUN bundle install

ADD . $APP_PATH
