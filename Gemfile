source 'https://rubygems.org'

ruby '>= 3.1.0'

gem 'figaro' # for local configuration settings that shouldn't be shared on GitHub

gem 'rails', '~> 8.0'

# Use sqlite3 as the database for Active Record
group :development, :test do
  gem 'sqlite3', '~> 2.1'
end

# Use SCSS for stylesheets
gem 'sassc-rails'

# Use Terser as compressor for JavaScript assets
gem 'terser'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 5.0'
gem 'coffee-script-source'

# Use jquery as the JavaScript library
gem 'jquery-rails'

gem 'jquery-turbolinks'

gem 'jquery-easing-rails'

# Use bootstrap-sass for design
gem 'bootstrap-sass', '~> 3.4'

gem 'font-awesome-rails'

# Turbolinks makes following links in your web application faster
gem 'turbolinks', '~> 5'

# Build JSON APIs with ease
gem 'jbuilder', '~> 2.7'

gem 'timepiece'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1'

gem 'devise', '~> 4.9'

gem 'omniauth-facebook', '~> 10.0'
gem 'omniauth-rails_csrf_protection'

group :production do
  gem 'pg', '~> 1.5'
end

gem 'tzinfo-data'

gem 'puma', '~> 6.0'

# Sprockets for asset pipeline
gem 'sprockets-rails'
