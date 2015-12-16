require 'rails_helper'

describe "SignInClient Integration"  do
	it "should sign in" do
	   response = double()
	   
	   allow(response).to receive_messages(
	   	:code => 200,
	   	:body => "my_token"
	   )
       
	   allow(RestClient).to receive(:post).and_return(response)
	   
	   request = SignInClient.new 
	   
	   server_response = request.sign_in "psoares@avenuecode.com", "081289"
	   expect(server_response.code).to eq 200
	end
end