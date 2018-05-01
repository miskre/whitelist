Hi guys,

Welcome to miskre whitelist source code.
We use Ruby on Rails to develop this app.

Ruby version: 2.3.5
Rails version: 4.2.5.1

1. Change config/application.yml.example to config/application.yml and enter value.
2. Run rake db:create to create db.
3. Run rake db:migrate to apply migrations to the database.
4. Run rake db:seed to generate mails contents and create operator user.
5. Start Redis server
6. Run bundle exec sidekiq to start sidekiq
