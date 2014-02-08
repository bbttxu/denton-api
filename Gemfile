source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'

gem 'rails-api'

# server
gem 'thin'

# database
gem 'mongoid', github: 'mongoid/mongoid'
gem 'bson_ext'
gem "geocoder"

# data format
gem 'active_model_serializers'

# background queues
gem 'resque'
gem 'resque-loner'

# repeating tasks
gem 'clockwork'

# workers
gem 'nokogiri'
gem 'chronic'

# scraping
gem 'httparty'
gem "cachebar", github: "bbttxu/cachebar"

group :development do
  gem 'guard'
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-rspec', require: false
  gem 'capistrano', '~> 2'
  gem 'guard-cane'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
end

group :test do
  gem 'database_cleaner'
end
