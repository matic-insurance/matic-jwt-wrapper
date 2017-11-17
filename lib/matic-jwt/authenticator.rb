module MaticJWT
  class Authenticator
    TOKEN_TYPE = 'Bearer: '.freeze

    def initialize(header)
      @token = extract_token(header)
    end

    def client_name
      payload.first['client_name']
    end

    def authenticate_with_secret!(secret)
      JWT.decode(@token, secret, true, algorithm: ALGORITHM)
    end

    private

    def extract_token(header)
      token = header.slice(TOKEN_TYPE.length..-1)
      validate_header_presence!(token)
      token
    end

    def payload
      JWT.decode(@token, nil, false)
    end

    def validate_header_presence!(token)
      raise(JWT::DecodeError, 'Authorization token is incorrect') unless token&.present?
    end
  end
end
