class OrkutClient
	include Authorizable

	BASE_URL = "http://localhost:3000/"

	SIGN_IN_CLIENT_URL = "login"

	LIST_USER_URL = "users"
   
    LIST_FRIENDS_URL = "friendship/me"
	
	def sign_in(user,password)
 	  response = RestClient.post BASE_URL + SIGN_IN_CLIENT_URL, {username: user, password: password }
 	  Authorizable.set_token(response.body)
 	  response
	end

	def sign_out
	   Authorizable.clear_token
	end

    def get_all_users
    	raise "user not signed in" unless Authorizable.signed_in?

    	response = RestClient::Request.execute(method: :get, url: LIST_USER_URL, headers: { :Authorization => Authorizable.get_token })
        response.body
    end


    def get_all_friends
    	raise "user not signed in" unless Authorizable.signed_in?

    	response = RestClient::Request.execute(method: :get, url: LIST_FRIENDS_URL,
                            payload: 'foo', headers: { :Authorization => Authorizable.get_token })
        response.body
    end
end