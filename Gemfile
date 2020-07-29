source 'https://rubygems.org'
ruby File.read('.ruby-version', mode: 'rb').chomp

gem 'rails', '~> 6.0'
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

group :development, :test do
  gem "bundler-audit"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '~> 1.3.6'

  gem 'rspec', '~> 3.5'
  gem 'rspec-rails', '~> 3.5'
  gem 'sqlite3', '~> 1.4.0'
end

group :development do
  gem 'capistrano', '= 3.4.0'
  gem 'capistrano-rails', '~> 1.1'
  gem 'capistrano-bundler', '~> 1.1'
  gem 'capistrano-logrotate', '0.4.0'
  gem 'capistrano-passenger', '~> 0.1.1'
end
