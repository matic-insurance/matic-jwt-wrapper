require 'active_support/time'
require 'jwt'

require 'matic-jwt/authenticator'
require 'matic-jwt/generator'
require 'matic-jwt/version'

module MaticJWT
  ALGORITHM = 'HS256'.freeze
  EXPIRATION = 1.minute
  SCHEME = 'Bearer'.freeze
end
