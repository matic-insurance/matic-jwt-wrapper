# Matic::Jwt

Matic's implementation of JWT authentication.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'matic-jwt'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install matic-jwt

## Usage

### Plain Ruby

Use `MaticJWT::Generator` to create JWT tokens or headers:
```ruby
generator = MaticJWT::Generator.new
token = generator.token_for('my_client', 'my_super_secret', additional_payload: 'test')
header = generator.authentication_header_for('my_client', 'my_super_secret', user_id: 'test@localhost.com')
```

### With Grape
Register `jwt_auth` strategy
```ruby
  Grape::Middleware::Auth::Strategies.add(
    :jwt_auth,
    MaticJWT::Grape::Middleware::Auth,
    ->(options) { [options] }
  )
```

Use ```:jwt_auth``` strategy and define lambda to obtain secret for by client name.
```ruby
   auth :jwt_auth,
        secret: -> (client_name) { ::ApiClient.find_by!(name: client_name).secret }
```

If you need to get any data from authentication payload use ::MaticJWT::Grape::Helper.
```ruby
    module ApiHelper
       include ::MaticJWT::Grape::Helper

        def current_client
          @current_client ||= ::ApiClient.find_by!(name: client_name)
        end

        private

        def client_name
          auth_payload['client_name']
        end
    end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/matic-jwt.
