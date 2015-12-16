module Authorizable
    def self.get_token
       @token
    end

    def self.set_token(token)
       @token = token
    end

    def self.clear_token
       @token = nil
    end

    def self.signed_in?
       !@token.nil?
    end
end