# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path("config/application", __dir__)

Rails.application.load_tasks

require "baza_migrations"
BazaMigrations.load_tasks

require "best_practice_project"
BestPracticeProject.load_tasks
