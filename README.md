# README

A database management tool written in Ruby on Rails with Bootstrap for the UI and Baza as the framework for communicating with the databases.

## Install

```bash
git clone https://github.com/kaspernj/baza_database_manager.git
cd baza_database_manager
bundle
bundle exec rails db:create db:schema:load baza:db:migrate db:seed
bundle exec rails s
```

Go to `http://localhost:300` in your browser.

Log in with "admin@example.com" with password "admin".


This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


Please feel free to use a different markup language if you do not plan to run
<tt>rake doc:app</tt>.
