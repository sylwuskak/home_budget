source 'https://rubygems.org'
ruby '2.7.4'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.1', '>= 6.1.7.2'

# Use sqlite3 as the database for Active Record
# Use Puma as the app server
gem 'puma', '~> 6.1', '>= 6.1.1'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 6.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '~> 4.2'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 5.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5.2', '>= 5.2.1'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :cli_development do
  gem 'pry-byebug'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'slim', '~> 5.0'
gem 'slim-rails', :git => 'git@github.com:spoterala/slim-rails.git'

gem 'bootstrap-sass', '~> 3.4', '>= 3.4.1'

gem 'active_link_to', '~> 1.0', '>= 1.0.5'
gem 'http_accept_language'

gem 'devise', '~> 4.9'
gem 'bootstrap-datepicker-rails', '~> 1.9', '>= 1.9.0.1'
gem 'nokogiri', '~> 1.14', '>= 1.14.2'
gem 'bootstrap-table-rails', '~> 1.20', '>= 1.20.2'
gem 'gruff', '~> 0.19.0'
gem 'simple_calendar', '~> 2.4', '>= 2.4.3'

gem 'will_paginate', '~> 3.3', '>= 3.3.1'
gem 'will_paginate-bootstrap', '~> 1.0', '>= 1.0.2'

gem 'rspec', '~> 3.12'
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

group :development, :test do
  gem 'pg', '~> 1.4', '>= 1.4.6'
  gem 'rails_12factor', '0.0.3'
end

group :production do
  gem 'pg', '~> 1.4', '>= 1.4.6'
  gem 'rails_12factor', '0.0.3'
end