require 'rails_helper'

describe FirstSocialMediaController do
	context "#export" do

	    let(:friends_json) do 
	    	[
	    		{
	    		 "__v" => 0,
	    		 "userRequester" => "1",
	    		 "userRequested" => "2",
	    		 "blockUserRequester" => false,
	    		 "blockUserRequested" => false,
	    		 "status":1
	    		 },
	    		 {
	    		 "__v":0,
	             "userRequester" => "1",
	             "userRequested" => "3",
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
	       stubbed_orkut_client = double()
	       sign_in_response = double()

	       allow(OrkutClient).to receive(:new).and_return(stubbed_orkut_client)

		   allow(sign_in_response).to receive_messages(
		   	:code => 200,
		   	:body => "my_token"
		   )   

		   allow(stubbed_orkut_client).to receive(:sign_in).and_return(sign_in_response)
		   allow(stubbed_orkut_client).to receive(:get_all_users).and_return(users_json)
		   allow(stubbed_orkut_client).to receive(:get_all_friends).and_return(friends_json)

		   get :export, {user: "user", password: "password"}
		   
		   expect(response.code).to eq "200"
		   expect(response.body).to start_with("friend_name,friend_email")
		   expect(response.body).to include("Pedro Silva,psilva@avenuecode.com")   
	    end
	end
end