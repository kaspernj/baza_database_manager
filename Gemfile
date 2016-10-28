source "https://rubygems.org"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "4.2.5"
gem "haml-rails"
gem "sqlite3"
gem "mysql2"
gem "mysql"
gem "pg"
gem "auto_autoloader", "0.0.4"
gem "cancancan"
gem "devise"
gem "twitter-bootstrap-rails"
gem "ransack"
gem "will_paginate"
gem "simple_form"
gem "awesome_translations"
gem "bootstrap_builders", "0.0.17"
gem "puma"

gem "sass-rails", "~> 5.0"
gem "coffee-rails", "~> 4.1.0"
gem "jquery-rails"
gem "sdoc", "~> 0.4.0", group: :doc

path = ["/home/kaspernj/Dev/Ruby", "/Users/kaspernj/Dev/Ruby"].find { |path_i| File.exist?(path_i) }

# gem "baza", path: "#{path}/baza"
#  gem "baza_migrations", path: "#{path}/baza_migrations"
#  gem "baza_models", path: "#{path}/baza_models"

gem "baza", github: "kaspernj/baza"
gem "baza_migrations", github: "kaspernj/baza_migrations"
gem "baza_models", github: "kaspernj/baza_models"

group :development, :test do
  gem "rspec-rails"
  gem "capybara"
  gem "factory_girl_rails"
  gem "forgery"
  gem "best_practice_project", github: "kaspernj/best_practice_project"
  gem "rubocop", require: false
  gem "scss-lint", require: false
  gem "haml_lint", require: false
  gem "coffeelint", require: false
  gem "rails_best_practices", require: false
end

group :development do
  gem "spring", "1.6.2"
  gem "spring-commands-rspec", "1.0.4"
  gem "spring-commands-rubocop", "0.1.0"
end
