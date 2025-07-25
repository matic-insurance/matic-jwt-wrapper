require 'active_support'
require 'active_support/core_ext'
require 'jwt'

require 'matic-jwt/authenticator'
require 'matic-jwt/generator'
require 'matic-jwt/version'

if Gem.loaded_specs.has_key?('grape')
  require 'matic-jwt/grape/helper'
  require 'matic-jwt/grape/middleware/request'
  require 'matic-jwt/grape/middleware/auth'
end

module MaticJWT
  ALGORITHM = 'HS256'.freeze
  EXPIRATION = 1.minute
  SCHEME = 'Bearer'.freeze
end
