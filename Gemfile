ruby '2.2.0'

source 'https://rubygems.org'

gem 'rails', '4.1.5'
gem 'turbolinks'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'haml-rails'
gem 'cancan'
gem 'bcrypt-ruby', '3.1.2'
gem 'bootstrap-sass'
gem 'bootstrap-sass-extras'
gem 'will_paginate-bootstrap', '~> 1.0.1'
gem 'cancancan'
gem 'angularjs-rails'
gem 'mysql2'
group :development do
  gem 'sqlite3'
end

group :test, :development do
  #gem 'factory_girl_rails'
  #gem 'capybara'
  #gem 'capybara_minitest_spec'
  #gem 'capybara-screenshot'
  #gem 'database_cleaner'
  #gem 'minitest',           :require => nil
  #gem 'poltergeist'
  #gem 'rr'
  #gem 'timecop'
  #gem 'webmock',            :require => nil
  #gem 'minitest-matchers'
end

group :test do
  gem 'factory_girl_rails', :require => false
  gem 'capybara'
  gem 'capybara_minitest_spec', :require => false
  gem 'capybara-screenshot'
  gem 'database_cleaner'
  gem 'minitest',           :require => nil
  gem 'poltergeist'
  gem 'rr'
  gem 'timecop'
  gem 'webmock',            :require => nil
  gem 'minitest-matchers'
end

group :production do
  gem 'pg', '0.15.1'
  gem 'rails_12factor', '0.0.2'
end