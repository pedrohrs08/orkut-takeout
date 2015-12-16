class UsersClient
    include Authorizable

    LIST_USER_URL = "http://localhost:3000/users"

    def get_all_users
    	raise "user not signed in" unless Authorizable.signed_in?

    	response = RestClient::Request.execute(method: :get, url: LIST_USER_URL, headers: { :Authorization => Authorizable.get_token })
        response.body
    end
end