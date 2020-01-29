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

####With Grape

Use ```:jwt_auth``` strategy and provide secret.
```ruby
   auth :jwt_auth, {
      secret: -> (client_name) { ::ApiClient.find_by!(name: client_name).secret }
   }
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
