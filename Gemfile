source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1'

# gem 'runr', '~> 0.3.3', :git => 'http://pswgithub.rds.lexmark.com/PerceptiveCloudPlatform/runr.git'
# gem 'runr', :git => 'http://pswgithub.rds.lexmark.com/PerceptiveCloudPlatform/runr.git', :branch => 'develop'
# uncomment (and comment the previous line) to use the version of runr checked out in your project folder
gem 'runr', :path => '../runr'

gem 'eventmachine'

# Use postgresql as the database for Active Record
# gem 'pg'
# Redis
gem 'redis'
# gem 'redis-namespace'
gem 'redis-store'

# Mongo
gem 'mongoid', git: 'git://github.com/mongoid/mongoid.git'
gem 'bson_ext'

# cleanup controllers
gem 'inherited_resources'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# use slim for templating instead of erb
# gem 'slim-rails'

# Use Uglifier as compressor for JavaScript assets
# gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
# gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
# gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more:
gem 'active_model_serializers'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
gem 'unicorn'

# Use puma as the app server
# gem 'puma'

# Use thin as the app server
# gem 'thin'

# Use Capistrano for deployment
gem 'capistrano', group: :development

group :development, :test do
  # Use debugger
  gem 'debugger'
  # gem 'pry'
  # gem 'pry-remote'
  # gem 'pry-nav'
  # gem 'pry-stack_explorer'
  # used only to rename the application, should normally be commented
   gem 'rename'
end

group :test do
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'factory_girl_rails', require: false
  gem 'database_cleaner'

end
