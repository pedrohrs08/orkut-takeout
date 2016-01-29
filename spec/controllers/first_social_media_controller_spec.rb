require 'rails_helper'

describe FirstSocialMediaController do
	context "#export" do

	    let(:friends_json) do 
	    	
	    	JSON.parse(%Q{[{"_id":"56ab7fc22e481306042c151d","user":{"_id":"56ab7ee72e481306042c1518","name":"QA Couse User 1","email":"qacourseuser1@avenuecode.com"}},{"_id":"56ab7fd22e481306042c151e","user":{"_id":"56ab7ef12e481306042c1519","name":"QA Couse User 2","email":"qacourseuser2@avenuecode.com"}},{"_id":"56ab7fd82e481306042c151f","user":{"_id":"56ab7efb2e481306042c151a","name":"QA Couse User 3","email":"qacourseuser3@avenuecode.com"}},{"_id":"56ab7fe22e481306042c1520","user":{"_id":"56ab7f042e481306042c151b","name":"QA Couse User 4","email":"qacourseuser4@avenuecode.com"}},{"_id":"56ab7fec2e481306042c1521","user":{"_id":"56ab7f102e481306042c151c","name":"QA Couse User 5","email":"qacourseuser5@avenuecode.com"}}]})
	    	
        end

        let(:user_json) do 
			JSON.parse(%Q{{"_id":"56608bd7edd9adc72c1b48ee","provider":"local","name":"Pedro","email":"pedrohrs08@gmail.com","password":"081289","__v":0,"role":"user"}})
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
		   allow(stubbed_orkut_client).to receive(:get_current_user_info).and_return(user_json)
		   allow(stubbed_orkut_client).to receive(:get_my_friends).and_return(friends_json)

		   get :export, {user: "user", password: "password"}
		   
		   expect(response.code).to eq "200"
		   expect(response.body).to start_with("my_name,my_email,friend_name,friend_email")
		   expect(response.body).to include("Pedro,pedrohrs08@gmail.com,QA Couse User 1,qacourseuser1@avenuecode.com")   
	    end
	end
end