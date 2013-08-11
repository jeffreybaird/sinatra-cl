# Sinatra-cl

This is a sinatra app generator based on [Ashley Williams'](http://heyashleyashley.com/) [Ratpack](https://github.com/ashleygwilliams/ratpack)

## Installation

Install it:

    $ gem install sinatra-cl

## Usage

Generate a Sinatra App:

    $ sinatra-cl new app
    $ cd app/
    $ bundle install
    $ shotgun

By default, Sinatra-cl generates a template with twitter bootstrap, to create a sinatra app without twitter bootstrap run:

    $ sinatra-cl new app --no-bootstrap

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
