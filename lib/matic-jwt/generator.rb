module MaticJWT
  class Generator
    def token_for(client_name, secret)
      payload = {client_name: client_name, exp: EXPIRATION.since.to_i}
      JWT.encode(payload, secret, ALGORITHM)
    end
  end
end
