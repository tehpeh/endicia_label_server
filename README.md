[![Gem Version](https://img.shields.io/gem/v/endicia_label_server-ruby.svg?style=flat-square)](http://badge.fury.io/rb/endicia_label_server-ruby)

# Endicia Label Server

Endicia Label Server Gem for accessing the Endicia Label Server API from Ruby. Using the gem you can:
  - Return quotes from the Endicia Label Server API
  - Book shipments
  - Return labels and tracking numbers for a shipment

This gem is currently used in production at [Veeqo](http://www.veeqo.com)

## Installation

```sh
$ gem install endicia_label_server-ruby
```

...or add it to your project's [Gemfile](http://bundler.io/).

## Documentation

Yard documentation can be found at [RubyDoc](http://www.rubydoc.info/github/veeqo/endicia_label_server-ruby).

## Sample Usage

### Return rates

```sh
# For testing on the command line
$ rake console
```

```ruby
require 'endicia_label_server'
server = EndiciaLabelServer::Connection.new(test_mode: true)
response = server.rate do |rate_builder|
  rate_builder.add :certified_intermediary, {
    account_id: ENV['ENDICIA_ACCOUNT_ID'],
    pass_phrase: ENV['ENDICIA_PASS_PHRASE'] # or token: ENV['ENDICIA_TOKEN']
  }
  rate_builder.add :requester_id, ENV['ENDICIA_REQUESTER_ID']
  rate_builder.add :mail_class, EndiciaLabelServer::SERVICES.keys.first
  rate_builder.add :mailpiece_dimensions, {
    length: '10',
    width: '10',
    height: '10'
  }
  rate_builder.add :weight_oz, "2"
  rate_builder.add :from_postal_code, '90210'
  rate_builder.add :to_postal_code, '02215'
  rate_builder.add :to_country_code, 'US'
end
```

```ruby
# Then use...
response.success?
```

## Running the tests

After installing dependencies with `bundle install`, you can run the unit tests using `rspec`.
