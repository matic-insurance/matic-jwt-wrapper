# frozen_string_literal: true

module MaticJWT
  module Grape
    module Middleware
      class Request
        AUTHORIZATION_KEYS = %w[
          Authorization
          HTTP_AUTHORIZATION
          X-HTTP_AUTHORIZATION
          X_HTTP_AUTHORIZATION
        ].freeze

        def initialize(env)
          @env = env
        end

        def valid?
          !@env[auth_key].nil?
        end

        def auth_token
          @env[auth_key]
        end

        private

        def auth_key
          @auth_key ||= AUTHORIZATION_KEYS.detect { |key| @env.key?(key) }
        end
      end
    end
  end
end
