# rusling.dk v2.0

## Installation

1. Ensure you have Ruby 2.4.1+

   You can use [rbenv](https://github.com/rbenv/rbenv) to manage multiple Ruby versions, or [rvm](https://rvm.io/)

2. Ensure you have PostgreSQL 9.6+
3. Ensure you have [Redis](https://redis.io) (Optional for now)

    On MacOS:

    ```sh
    $ brew install redis
    ```

    On Debian Linux:

    ```sh
    $ apt-get install redis
    ```

4. Ensure you have a JavaScript Runtime

    On MacOS:

    You do not need to do anything.  Apple JavaScriptCore fulfills this dependency. If not, install `$ brew install nodejs`, as it's the easiest setup.

    On Debian Linux:

    ```sh
    $ apt-get install nodejs
    ```
    If you wish to use another runtime you can use one listed [here](https://github.com/rails/execjs/blob/master/README.md).

5. Clone this repo
6. If you don’t have the `bundler` Ruby gem, install it:

    ```sh
    $ gem install bundler
    ```

7. Wherever you cloned the repo, go to that directory and install dependencies:

    ```sh
    $ bundle install --without production
    ```

8. Set up your database. The simple way to do this is:

    ```sh
    $ bundle exec rails db:setup
    ```

    That will create a database, set up all the tables, create an admin user, and add some sample data. Make note of the admin user e-mail and password that are shown; you’ll need them to log in and create more users, import more data, or make annotations.

    If you're getting error such as `FATAL: role "user" doesn't exist. Couldn't create database.` check [troubleshooting](#troubleshooting) below.

9. Start the server!

    ```sh
    $ bundle exec rails server
    ```

    You should now have a server running and can visit it at http://localhost:3000/. Open that up in a browser and go to town!

10. Bulk importing (and, in the future, potentially other features) make use of a
   Redis queue. If you plan to use any of these features, you must also start a
   Redis server and worker.

   Start redis:

   ```sh
   $ redis-server
   ```

   Start a worker: (Not applicable yet)

   ```sh
   $ sidekiq -q default -q mailers
   ```

## Manual Postgres Setup

If you don’t want to populate your DB with seed data, want to manage creation of the database yourself, or otherwise manually do database setup, run any of the following commands as desired instead of `rails db:setup`:

```sh
$ bundle exec rails db:create       # Connects to Postgres and creates a new database
$ bundle exec rails db:schema:load  # Populates the database with the current schema
$ bundle exec rails db:seed         # Adds an admin user and sample data
```

If you skip `rails db:seed`, you’ll still need to create an Admin user. You should not do this through the database since the password will need to be properly encrypted. Instead, open the rails console with `rails console` and run the following:

```ruby
User.create(
  email: '[your email address]',
  password: '[the password you want]',
  admin: true,
  confirmed_at: Time.now
)
```

## Troubleshooting

If you are getting errors such as `FATAL: role "user" doesn't exist. Couldn't create database.` while running `rails db:setup` or `rails db:create` then it may mean that your database is password protected. There are two ways to setup required databases:

1. Loosen local Postgres database security to allow local users without password

    You have to edit [pg_hba.conf](https://www.postgresql.org/docs/9.6/static/auth-pg-hba-conf.html) config file (`/etc/postgresql/9.6/main/pg_hba.conf` on Unix) and add or update authorization line for local logins from `md5` to `trust`:

    ```
    # "local" is for Unix domain socket connections only
    local   all             all                                     trust
    # IPv4 local connections:
    host    all             all             127.0.0.1/32            trust
    ```

    Create Postgres superuser that will link to your account:
    ```
    sudo -u postgres createuser `whoami` -ds
    ```

    Now `bundle exec rails db:setup` command should work.
