# Sinatra Template

## About
  Sinatra Template with ActiveRecord, Migration, ERB and RSpec.

  Folked from [shell/sinatra-template](https://github.com/shell/sinatra-template) and modified to fit my requiremant.

  Original:
  > Recently I found myself doing a very simple services for my cliens with Sinatra. There is a lot of guides, tutorials and FAQs around the internet. But it seems that there is no good Sinatra template with testing coverate, basic files structure, etc. So I made one.

## App
  * ActiveRecord ORM
  * Mysql2
  * ERB
  * rake tasks for db management
  * RSpec
  * HTTP basic authentication
  * Some essential Rails helpers
  * Ready for deploy with passenger (_/config/setup\_load\_paths.rb_)

  You can switch environments with `RACK_ENV=test`
  If you have old version of rake installed in gemset, you need to prepend all rake commands with `bundle exec`

  Some prefer to extract controllers, models, helpers in corresponding folders and split them over files. It is a matter of taste, bit if you have a lot of files, consider using Rails instead.


## Helpers
  * link\_to - it is not full copy of Rails's link_to, this version produces only anchor tag with parameters
  * in\_groups\_of - iteration over collection by groups
  * options\_for\_select

## Rake

    rake -T

    rake db:create_migration  # create an ActiveRecord migration
    rake db:migrate           # migrate the database (use version with VERSION=n)
    rake db:rollback          # roll back the migration (use steps with STEP=n)
    rake db:schema:dump       # dump schema into file
    rake db:schema:load       # load schema into database


## Installation

    $ git clone https://github.com/ascendbruce/sinatra-template.git
    $ cd sinatra-template
    # (you should create database by hand. and set config/database.yml correctly)
    $ rake db:migrate
    $ ruby application.rb

## Testing
  Testing suite include overall application behaviour(/spec/app_spec.rb) and model specific testing(products_spec.rb, categories_spec.rb).
  Specific test include unit testing for model and actions tests for app

  Do not forget to create and migrate testing database before:

    $ RACK_ENV=test rake db:migrate

  Run tests once

    $ rspec spec/

  Autotest friendly

    $ ./autotest

  Testing coverate generated with _SimpleCov_ flavor

      $ open coverage/index.html

## Deploy

  Deploy it as regular rack/rails application. Just point root to /app/public and set RACK_ENV variable

## Author
  Vladimir Penkin
  Bruce Li
