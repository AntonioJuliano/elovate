ruby "2.3.1"
source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0'

gem "active_model_serializers", '~> 0.10.0'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'mongoid', '~> 6.0.0.rc0'
gem 'bson_ext'
gem 'redis-rails', '~> 5.0.1'
gem 'database_cleaner', '~> 1.5.3'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors', '~> 0.4.0'
gem 'rack-attack', '~> 5.0.1'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'pry-byebug', '~> 3.4.0'
  gem 'rspec-rails', '~> 3.5'
  gem "factory_girl_rails", "~> 4.7.0"
end

group :development do
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'capistrano-rails'
end

