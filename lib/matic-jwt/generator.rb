module MaticJWT
  class Generator
    EXPIRATION_TYPE = ActiveSupport::Duration

    def initialize(expiration: nil)
      @custom_expiration = expiration
    end

    def token_for(client_name, secret)
      ensure_expiration_type!
      payload = {client_name: client_name, exp: expiration.since.to_i}
      JWT.encode(payload, secret, ALGORITHM)
    end

    private

    def ensure_expiration_type!
      raise(JWT::DecodeError, "Incorrect type for expiration. Should be #{EXPIRATION_TYPE}") unless expiration.is_a?(EXPIRATION_TYPE)
    end

    def expiration
      @custom_expiration || EXPIRATION
    end
  end
end
