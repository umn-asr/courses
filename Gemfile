source "https://artifactory.umn.edu/artifactory/api/gems/asr-rubygems"
ruby "2.7.1"

gem 'rails', '~> 6.0.6'
gem 'sprockets', '~> 3.7.2'

group :production, :staging do
  gem 'ruby-oci8'
  gem 'activerecord-oracle_enhanced-adapter', '~> 6.0'
end

gem 'oj', '~> 2.18.5'
gem 'query_string_search', '~> 0.0.7'
gem 'rack-cache', '~> 1.2'
gem 'whenever', '~> 0.9.4', :require => false
gem 'redis-rails', '~> 5.0.0'
gem 'cache_pool', path: 'lib/cache_pool'
gem 'lograge'
gem 'logstash-event'
gem "mini_portile2", "~>2.8"

group :development, :test do
  gem "bundler-audit"
  gem "byebug"
  gem "oracle_cleaner"
  gem "reek"
  gem "standard"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '~> 1.3.6'

  gem 'rspec', '~> 3.5'
  gem 'rspec-rails', '~> 3.5'
end

group :development do
  gem 'capistrano', '= 3.16.0'
  gem 'capistrano-rails', '~> 1.1'
  gem 'capistrano-bundler', '~> 1.1'
  gem 'capistrano-logrotate', '0.4.0'
  gem 'capistrano-passenger', '~> 0.1.1'
end
