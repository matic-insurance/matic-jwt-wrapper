module MaticJWT
  module Grape
    module Middleware
      class Auth
        def initialize(app, options)
          @app = app
          @secret_reader = options[:secret]
        end

        def call(env)
          @env = env

          validate_request
          decode_payload
          authenticate!
          continue!
        end

        private

        def validate_request
          raise JWT::VerificationError, 'Authorization token is invalid' unless request.valid?
        end

        def decode_payload
          @env['auth_payload'] = jwt_authenticator.payload&.first
        end

        def authenticate!
          jwt_authenticator.authenticate_with_secret!(secret)
        end

        def continue!
          @app.call(@env)
        end

        def jwt_authenticator
          ::MaticJWT::Authenticator.new(request.auth_token)
        end

        def secret
          @secret_reader.call(jwt_authenticator.client_name)
        end

        def request
          @request ||= ::MaticJWT::Grape::Middleware::Request.new(@env)
        end
      end
    end
  end
end

Grape::Middleware::Auth::Strategies.add(:jwt_auth, ::MaticJWT::Grape::Middleware::Auth, ->(options) { [options] })
