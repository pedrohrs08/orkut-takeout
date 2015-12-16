require 'rails_helper'

describe SocialMediaController do
	context "#export" do

	    let(:friends_json) do 
	    	[
	    		{
	    		 "__v" => 0,
	    		 "vipUserRequester" => "1",
	    		 "vipUserRequested" => "2",
	    		 "blockUserRequester" => false,
	    		 "blockUserRequested" => false,
	    		 "status":1
	    		 },
	    		 {
	    		 "__v":0,
	             "vipUserRequester" => "1",
	             "vipUserRequested" => "3",
	             "blockUserRequester" => false,
	             "blockUserRequested" => false,
	             "status":1
	         	}
	    	]
        end

        let(:users_json) do 
			[{
				"_id": "1",
				"provider": "local",
				"name": "Luis Perez",
				"email": "lperez@avenuecode.com",
				"password": "123456",
				"__v": 0,
				"role": "user"
			}, 
			{
				"_id": "2",
				"provider": "local",
				"name": "Eduardo Silva",
				"email": "esilva@avenuecode.com",
				"password": "123",
				"__v": 0,
				"role": "user"
			},
			{
				"_id": "3",
				"provider": "local",
				"name": "Pedro Silva",
				"email": "psilva@avenuecode.com",
				"password": "123",
				"__v": 0,
				"role": "user"
			}]
        end

	    it "should return a CSV string" do
		   
		   sign_in_response = double()
		   user_list_response = double()
		   friend_list_response = double()

		   allow(sign_in_response).to receive_messages(
		   	:code => 200,
		   	:body => "my_token"
		   )

		   allow(user_list_response).to receive(:body).and_return(users_json)
		   allow(friend_list_response).to receive(:body).and_return(friends_json)
	       
		   allow(RestClient).to receive(:post).and_return(sign_in_response)
		   allow(RestClient::Request).to receive(:execute).with(hash_including(url: /users/)).and_return(user_list_response)
		   allow(RestClient::Request).to receive(:execute).with(hash_including(url: /friendship/)).and_return(friend_list_response)

		   get :export, {user: "user", password: "password"}
		   
		   expect(response.code).to eq "200"
		   expect(response.body).to start_with("friend_name,friend_email")
		   expect(response.body).to include("Pedro Silva,psilva@avenuecode.com")
	    end
	end
end