class SignInClient
  include Authorizable	

	SIGN_IN_CLIENT_URL = "http://localhost:3000/login"

	def sign_in(user,password)
 	  response = RestClient.post SIGN_IN_CLIENT_URL, {username: user, password: password }
 	  Authorizable.set_token(response.body)
 	  response
	end

	def sign_out
	    Authorizable.clear_token
	end
end

