module MaticJWT
  class Authenticator
    def initialize(request)
      @token = extract_token(request)
    end

    def client_name
      payload.first['client_name']
    end

    def authenticate_with_secret!(secret)
      JWT.decode @token, secret, true, algorithm: ALGORITHM
    end

    private

    def extract_token(request)
      header = request.headers['Authorization']
      validate_header_presence!(header)
      header.slice(8..-1)
    end

    def payload
      JWT.decode(@token, nil, false)
    end

    def validate_header_presence!(header)
      raise(JWT::DecodeError, 'Authorization header is missing') if header.nil?
    end
  end
end
