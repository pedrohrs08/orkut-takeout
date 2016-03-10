class OrkutClient

	BASE_URL = "http://52.3.198.200:3000/"

	SIGN_IN_CLIENT_URL = "login"

	GET_LOGGED_USER_URL = "users/me"
   
    LIST_MY_FRIENDSHIPS = "friendships/me"
	
	def sign_in(user,password)
 	  response = RestClient.post BASE_URL + SIGN_IN_CLIENT_URL, {username: user, password: password }
 	  Authorizable.set_token(response.body)
 	  response
	end

	def sign_out
	   Authorizable.clear_token
	end

    def get_current_user_info
    	raise "user not signed in" unless Authorizable.signed_in?

    	response = RestClient::Request.execute(method: :get, 
            url: BASE_URL + GET_LOGGED_USER_URL, 
            headers: { :Authorization => Authorizable.get_token }
            )
        JSON.parse(response.body)
    end


    def get_my_friends
    	raise "user not signed in" unless Authorizable.signed_in?
    	response = RestClient::Request.execute(method: :get, url: BASE_URL + LIST_MY_FRIENDSHIPS, headers: { :Authorization => Authorizable.get_token })
        JSON.parse(response.body)
    end
end