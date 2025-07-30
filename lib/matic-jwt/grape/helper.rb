# frozen_string_literal: true

module MaticJWT
  module Grape
    module Helper
      def auth_payload
        env['auth_payload']
      end
    end
  end
end
