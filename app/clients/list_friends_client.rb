class ListFriendsClient
    include Authorizable

    LIST_FRIENDS_URL = "http://localhost:3000/friendship/me"

    def get_all_friends
    	raise "user not signed in" unless Authorizable.signed_in?

    	response = RestClient::Request.execute(method: :get, url: LIST_FRIENDS_URL,
                            payload: 'foo', headers: { :Authorization => Authorizable.get_token })
        response.body
    end
end