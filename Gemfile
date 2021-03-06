source 'https://rubygems.org'

ruby '1.9.3'

#### Ruby on Rails ####
gem 'rails', '3.2.13'

# gem 'rails', :git => 'git://github.com/rails/rails.git'
gem 'jquery-rails'

gem 'rails-erd' # so it wont crash in production

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
  # FIXME: estas 3 gemas no parecen adecuadas para este grupo
  gem 'compass'
  gem 'mongo'
  gem 'bson_ext'
  gem 'annotate'
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
gem 'devise', '3.1.1'  # authentication
gem 'omniauth'
gem 'omniauth-facebook'
gem 'oauth2'
gem 'cancan'  # authorization
gem 'rolify'

#### Ruby API Builder Language ####
gem 'rabl'
# gem 'yajl-ruby'
gem 'oj'
gem 'msgpack', '~> 0.4.5'


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
gem 'globalize', '~> 3.0.0'
#gem 'globalize3', :git => 'git://github.com/svenfuchs/globalize3.git'
gem 'paperclip-globalize3'

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
gem 'sass-rails',   '~> 3.2.3'
gem 'coffee-rails', '~> 3.2.1'
gem "haml-rails"
gem 'simple_form'
gem 'country_select'
gem "chartkick"
gem 'groupdate'
gem "figaro"

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'
