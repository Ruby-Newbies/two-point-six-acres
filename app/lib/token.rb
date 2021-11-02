class Token
    def self.encode(payload)
      JWT.encode(payload, Rails.application.secrets.secret_key_base. to_s)
    end
  
    def self.decode(token)
      decoded = JWT.decode(token, Rails.application.secrets.secret_key_base. to_s)[0]
      HashWithIndifferentAccess.new decoded
    end
  end