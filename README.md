# Sinatra Template

## About

Sinatra Template is an example sinatra application with ActiveRecord, Migration, Log4r, ERB. Suitable for simple, small web applications.

Sinatra Template was inspired by [shell/sinatra-template](https://github.com/shell/sinatra-template) by Vladimir Penkin.

## Including

* ActiveRecord ORM
* Mysql2
* ERB
* rake tasks for db management
* Log4r
* Bundler
* HTTP basic authentication
* Some Rails-like helpers
* Ready for deploy with passenger (`/config/setup_load_paths.rb`)

## Convensions

### Model

It does allow multi files. But it is not recommended. If you are going to build a complicated app. You should use Rails instead.

### Settings

Config Files:

* config/database.yml (should be gitignored)
* config/application.yml
* config/confidential.yml (should be gitignored)
* config/log4r.yml

Note:

* The value of `site_root_url` should not include the ending `/`

### environments

You can switch environments with `RACK_ENV=test`

## available rake tasks

    rake -T

will show:

    rake db:create_migration  # create an ActiveRecord migration
    rake db:migrate           # migrate the database (use version with VERSION=n)
    rake db:rollback          # roll back the migration (use steps with STEP=n)
    rake db:schema:dump       # dump schema into file
    rake db:schema:load       # load schema into database


## Installation

    $ git clone https://github.com/ascendbruce/sinatra-template.git
    $ cd sinatra-template
    # cp config/database.yml.example database.yml # and edit it
    # cp config/confidential.yml.example confidential.yml # and edit it
    $ rake db:migrate
    $ ruby application.rb

## Deploy

Deploy it as regular rack application.

## Contributors
  * Bruce Li
