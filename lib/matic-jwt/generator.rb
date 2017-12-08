module MaticJWT
  class Generator
    def initialize(expiration: EXPIRATION)
      @expiration = expiration
    end

    def token_for(client_name, secret)
      payload = {client_name: client_name, exp: @expiration.since.to_i}
      JWT.encode(payload, secret, ALGORITHM)
    end

    def authentication_header_for(client_name, secret, scheme: SCHEME)
      token = token_for(client_name, secret)
      "#{scheme} #{token}"
    end
  end
end
