require 'rails_helper'

describe SignInClient do
 	let(:sign_in_client) {sign_in_client = SignInClient.new}
   
    let(:stub_response) do 
       stub_response = double()
       allow(stub_response).to receive(:body).and_return("my_token")
       stub_response
    end 

 	it "should call the sign in service from orkut" do	
 	    expect(RestClient).to receive(:post).with(/login/,hash_including(username: "pedro", password: "pedro123")).and_return(stub_response)
  	    sign_in_client.sign_in("pedro","pedro123")
 	end
   
    it "should call the sign in service from orkut" do
        sign_in_client.sign_out
        expect(Authorizable.get_token).to be_nil
 	end
end