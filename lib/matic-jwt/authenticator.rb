module MaticJWT
  class Authenticator
    def initialize(header, scheme: SCHEME)
      @scheme = scheme
      @token = extract_token(header)
    end

    def client_name
      payload.first['client_name']
    end

    def authenticate_with_secret!(secret)
      JWT.decode(@token, secret, true, algorithm: ALGORITHM)
    end

    def payload
      JWT.decode(@token, nil, false)
    end

    private

    def extract_token(header)
      token = header&.slice(@scheme.length + 1..-1)
      validate_header_presence!(token)
      token
    end

    def validate_header_presence!(token)
      raise(JWT::DecodeError, 'Authorization token is incorrect') unless token&.present?
    end
  end
end
