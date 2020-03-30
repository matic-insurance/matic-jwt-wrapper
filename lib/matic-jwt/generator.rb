module MaticJWT
  class Generator
    def initialize(expiration: EXPIRATION, scheme: SCHEME)
      @expiration = expiration
      @scheme = scheme
    end

    def token_for(client_name, secret)
      payload = {client_name: client_name, exp: @expiration.since.to_i}
      JWT.encode(payload, secret, ALGORITHM)
    end

    def authentication_header_for(client_name, secret)
      token = token_for(client_name, secret)
      "#{@scheme} #{token}"
    end
  end
end
