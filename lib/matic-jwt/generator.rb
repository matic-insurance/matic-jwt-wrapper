module MaticJWT
  class Generator
    def initialize(expiration: EXPIRATION)
      @expiration = expiration
    end

    def token_for(client_name, secret)
      payload = {client_name: client_name, exp: @expiration.since.to_i}
      JWT.encode(payload, secret, ALGORITHM)
    end

    def authentication_header_for(client_name, secret, token_type = TOKEN_TYPE)
      token = token_for(client_name, secret)
      "#{token_type} #{token}"
    end
  end
end
