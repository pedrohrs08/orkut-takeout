module Authorizable
  def self.get_token
    @token
  end

  def self.set_token(token)
    @token = "bearer " + token[1..(token.size - 2)]
  end

  def self.clear_token
    @token = nil
  end
  
  def self.signed_in?
    !@token.nil?
  end
end
