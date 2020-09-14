class TokenValidationService
    TOKE_REGEX = /Bearer (.+)/

    def self.decode(token)
        if token && token.match(TOKE_REGEX)
            token = token.match(TOKE_REGEX)[1]
            begin
                return JWT.decode(token, 'my_secret', true, algorithm: 'HS256')
            rescue JWT::DecodeError
                nil
            end
        end
        nil
    end
  
    def self.encode(payload)
        JWT.encode(payload, 'my_secret')
    end
end
