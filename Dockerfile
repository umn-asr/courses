FROM asr-docker-local.artifactory.umn.edu/ruby_2_7_1_node_16_oracle:0.0.7 as courses
ARG BUNDLER_VERSION="2.3.26"

WORKDIR /app

ENV MAKE="make --jobs 8"

COPY Gemfile Gemfile.lock ./

RUN gem install bundler:$BUNDLER_VERSION

COPY . .

RUN bundle config --local local.cache_pool lib/cache_pool
RUN bundle install

CMD rails s
