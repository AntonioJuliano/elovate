ruby "2.3.1"
source 'https://rubygems.org'

gem 'rails', '~> 5.0.0'

gem "active_model_serializers", '~> 0.10.0'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'mongoid', '~> 6.0.0.rc0'
gem 'bson_ext'
gem 'redis-rails', '~> 5.0.1'
gem 'database_cleaner', '~> 1.5.3'
gem 'mlanett-redis-lock', '~> 0.2.7', require: 'redis-lock'
gem 'faraday', '~> 0.9.2'
gem 'retryable', '~> 2.0.4'
gem 'rack-cors', '~> 0.4.0'
gem 'rack-attack', '~> 5.0.1'

group :development, :test do
  gem 'pry-byebug', '~> 3.4.0'
  gem 'rspec-rails', '~> 3.5'
  gem "factory_girl_rails", "~> 4.7.0"
  gem 'webmock', '~> 2.1'
  gem 'dotenv-rails', '~> 2.1', '>= 2.1.1'
end

group :development do
  gem 'spring'
  gem 'capistrano-rails'
end

