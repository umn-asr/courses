source 'https://rubygems.org'

gem 'rails', '4.2.0'

group :production, :staging do
  gem 'ruby-oci8', '2.1.7'
  gem 'activerecord-oracle_enhanced-adapter', :git => 'https://github.com/rsim/oracle-enhanced.git', :branch => 'rails42'
end

gem 'rabl'
gem 'oj'

group :development, :test do
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  gem 'rspec', '~> 3.2'
  gem 'rspec-rails', '~> 3.2'
  gem 'sqlite3'
end

group :development do
  gem 'capistrano', '= 3.3.5'
  gem 'capistrano-rails', '~> 1.1'
  gem 'capistrano-bundler', '~> 1.1'
  gem 'capistrano-passenger'
end
