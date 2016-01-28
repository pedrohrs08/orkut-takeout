require 'rails_helper'

describe OrkutClient do
	
 	let(:orkut_client) { orkut_client = OrkutClient.new }
   
    let(:stub_response) do 
       stub_response = double()
       allow(stub_response).to receive(:body).and_return("my_token")
       stub_response
    end 

    context "Authentication" do

	 	it "should call the sign in service from orkut" do	
	 	    expect(RestClient).to receive(:post).with(/login/,hash_including(username: "pedro", password: "pedro123")).and_return(stub_response)
	  	    orkut_client.sign_in("pedro","pedro123")
	  	    expect(Authorizable.get_token).to_not be_nil
	 	end
	   
	    it "should call the sign in service from orkut" do
	        orkut_client.sign_out
	        expect(Authorizable.get_token).to be_nil
	 	end

    end

    context "#get_all_friends" do
		it "should throw an exception if user is not signed in" do
			expect { orkut_client.get_all_friends }.to raise_exception("user not signed in") 
		end

		it "should call my friends endpoint if user is signed in" do
			allow(Authorizable).to receive(:signed_in?).and_return(true)
			expect(RestClient::Request).to receive(:execute).with(hash_including(url: /me/)).and_return(stub_response)
			orkut_client.get_all_friends
		end
	end	

	context "#get_all_users" do
		it "should throw an exception if user is not signed in" do
			expect { orkut_client.get_all_users }.to raise_exception("user not signed in") 
		end

		it "should call my friends endpoint if user is signed in" do
			allow(Authorizable).to receive(:signed_in?).and_return(true)
			expect(RestClient::Request).to receive(:execute).with(hash_including(url: /users/)).and_return(stub_response)
			orkut_client.get_all_users
		end
	end	
end