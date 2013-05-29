source 'https://rubygems.org'

#### Ruby on Rails ####
gem 'rails', '3.2.13'

# gem 'rails', :git => 'git://github.com/rails/rails.git'
gem 'jquery-rails'

#### Database Setup ####
group :development do
  gem 'taps'              # for heroku db:pull
  gem 'yaml_db'
  gem 'sqlite3'
  gem 'meta_request'      # for rails_panel
  gem 'pry-rails'         # for Pry
  gem "better_errors"
  gem "binding_of_caller" # for better_errors
  gem 'quiet_assets'
  gem 'rails-erd'         # create DB diagram
  gem 'annotate'
  gem "guard-bundler", ">= 1.0.0"
  gem "guard-rails", ">= 0.4.0"
  gem "guard-rspec"
  gem "guard-annotate"
  gem "rb-inotify", ">= 0.9.0", :require => false
  gem "rb-fsevent", ">= 0.9.3", :require => false
  gem "rb-fchange", ">= 0.0.6", :require => false
  # FIXME: estas 2 gemas no parecen adecuadas para este grupo
  gem 'mongo'
  gem 'bson_ext'
end

group :development , :test do
  gem "rspec-rails" , "~> 2.13.0"
  gem "factory_girl_rails" , "~> 4.2.1"
end
group :test do
  gem "faker" , "~> 1.1.2"
  gem "capybara" , "~> 2.0.2"
  gem "database_cleaner" , "~> 0.9.1"
  gem "launchy" , "~> 2.2.0"
end

group :production do
  gem 'thin'
  gem 'newrelic_rpm'
end

gem 'pg'

#### Rails Admin Setup ####
gem 'rails_admin'
gem 'rails_admin_update_tablets', :path => "vendor/engines/rails_admin_update_tablets"
gem 'rails_admin_import', :git => "git://github.com/naveed-ahmad/rails_admin_import.git"

# gem 'rails_admin', :git => 'git://github.com/tocarta/rails_admin.git'
gem 'devise'  # authentication
gem 'omniauth'
gem 'omniauth-facebook'
gem 'oauth2'
gem 'cancan'  # authorization
gem 'rolify'

#### Ruby API Builder Language ####
gem 'rabl'
# gem 'yajl-ruby'
gem 'oj'


#### HTTP Client used for Subtledata ####
gem "faraday", "~> 0.8.4"

# JSON gem
# gem 'json'

#### Paperclip and Amazon S3 ####
# gem 'paperclip', '~> 2.7'
gem "paperclip", "~> 3.4.0"
gem 'aws-sdk', '~> 1.3.4'

# Habilitando Push Notifications
gem 'pusher'

# Debugger for development
# group :development do
  # gem 'linecache19'
  # gem 'ruby-debug19', :require => 'ruby-debug'
# end

# Twitter gem
gem 'twitter_oauth'

# Translation
gem 'globalize3', :git => 'git://github.com/svenfuchs/globalize3.git'

# Smart dates and times
gem 'chronic'
gem 'chronic_duration'
gem 'chronic18n'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'uglifier', '>= 1.0.3'
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer'
end

gem 'sprockets'
gem 'sass-rails',   '~> 3.2.3'
gem 'compass'
gem 'bootstrap-sass', '~> 2.3.1.0'
gem "font-awesome-rails"
gem 'coffee-rails', '~> 3.2.1'
gem "haml-rails"
gem 'simple_form'
gem 'country_select'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'
