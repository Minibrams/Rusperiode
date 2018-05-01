# Studego-kort v2.0

## Installation

1. Ensure you have Ruby 2.5.1+

   You can use [rbenv](https://github.com/rbenv/rbenv) to manage multiple Ruby versions, or [rvm](https://rvm.io/)

2. Clone this repo
3. If you don’t have the `bundler` Ruby gem, install it:

    ```sh
    $ gem install bundler
    ```

4. Wherever you cloned the repo, go to that directory and install dependencies:

    ```sh
    $ bundle install
    ```

5. Compile html file

    ```sh
    $ ruby builder.rb > output/index.html
    ```