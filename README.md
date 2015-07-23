[![Circle CI](https://circleci.com/gh/HaiTo/faraday_specific_logging.svg?style=svg)](https://circleci.com/gh/HaiTo/faraday_specific_logging)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'faraday_specific_logging'

# or

gem install faraday_specific_logging
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install specific_logging

## Usage

```rb
@conn = Faraday.new(url: 'example.com') do |builder|
  builder.specific_logging, {logger: Rails.logger, target_key: 'hoge'}
  builder.request :json
  builder.adapter :net_http
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/haito/specific_logging. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

