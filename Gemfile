source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }
ruby '2.7.0'
gem 'rails', '~> 6.0.2', '>= 6.0.2.1'
gem 'bcrypt'
gem 'mysql2', '>= 0.4.4'
gem "puma", ">= 4.3.5"
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 4.0'
gem 'jbuilder', '~> 2.7'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'slim'
gem 'html2slim'
gem 'bootstrap', '~> 4.4.1'
gem 'jquery-rails'
gem 'rails-i18n'
gem 'carrierwave'
gem 'fog-aws'
gem 'rmagick'
gem 'will_paginate', '3.1.7'
gem 'bootstrap-will_paginate', '1.0.0'
gem 'will_paginate-bootstrap4'
gem 'rakuten_web_service'
gem 'rails-controller-testing'
gem 'ransack'
gem 'font-awesome-sass', '~> 5.12.0'
gem 'gretel'
gem "actionview", ">= 6.0.2.2"
gem "activesupport", ">= 6.0.3.1"
gem "actionpack", ">= 6.0.3.1"
gem "activestorage", ">= 6.0.3.1"

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara'
  gem 'webdrivers', require: !ENV['SELENIUM_REMOTE_URL']
  gem 'selenium-webdriver'
end

group :production do
  gem 'unicorn'
  gem 'sassc', '~> 2.1.0'
end
