module MaticJWT
  class Generator
    EXPIRATION_TYPE = ActiveSupport::Duration

    def initialize(expiration: nil)
      @custom_expiration = expiration
    end

    def token_for(client_name, secret)
      payload = {client_name: client_name, exp: expiration.since.to_i}
      JWT.encode(payload, secret, ALGORITHM)
    end

    private

    def expiration
      @custom_expiration || EXPIRATION
    end
  end
end
