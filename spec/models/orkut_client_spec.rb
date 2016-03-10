require 'rails_helper'

describe OrkutClient do
    
    let(:sign_in_response){
    	sign_in_response = double()
    	allow(sign_in_response).to receive(:body).and_return("my token")
    	sign_in_response
    } 

    let(:current_user_info_response){
      current_user_info_response = double()
      allow(current_user_info_response).to receive(:body).and_return("{}")
      current_user_info_response
    }


	it "should sign_in to Orkut Server" do 
      #setup 
      orkut_client = OrkutClient.new
      
      #verify
      expect(RestClient).to receive(:post)
      .with(/login/, 
      	hash_including(
      		username: "pedrohrs08@gmail.com",
      		password: "081289"
      		)
      	).and_return(sign_in_response)

      #exercise
      orkut_client.sign_in("pedrohrs08@gmail.com","081289")
      expect(Authorizable).to be_signed_in
	end

	it "should sign_out from Orkut Server" do 
       #setup
       orkut_client = OrkutClient.new
       
       allow(RestClient).to receive(:post).and_return(sign_in_response)
       orkut_client.sign_in("my_user","my_password")

       #exercise
       orkut_client.sign_out

       #verify
       expect(Authorizable).to_not be_signed_in
	end

  context "#get_current_user_info" do 
    it "should throw an exception if the user is not signed in" do 
        orkut_client = OrkutClient.new 
        expect{ orkut_client.get_current_user_info }.to raise_error(/not signed in/)
    end

    it "should call the get current user info endpoint passing the authentication token" do
       

        allow(Authorizable).to receive(:signed_in?).and_return(true)
        allow(Authorizable).to receive(:get_token).and_return("my token")
        
        expect(RestClient::Request).to receive(:execute).with(hash_including(
            method: :get,
            url: /users\/me/,
            headers: { :Authorization => "my token" }
        )).and_return(current_user_info_response)

         orkut_client = OrkutClient.new

         response = orkut_client.get_current_user_info
         expect(response).to be_a(Hash)
    end
  end
end









