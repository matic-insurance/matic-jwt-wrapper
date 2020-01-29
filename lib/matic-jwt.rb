require 'active_support/time'
require 'jwt'

require 'matic-jwt/authenticator'
require 'matic-jwt/generator'
require 'matic-jwt/version'

if Gem::Specification.find_all_by_name('grape').present?
  require 'matic-jwt/grape/helper'
  require 'matic-jwt/grape/middleware/request'
  require 'matic-jwt/grape/middleware/auth'
end

module MaticJWT
  ALGORITHM = 'HS256'.freeze
  EXPIRATION = 1.minute
  SCHEME = 'Bearer'.freeze
end
