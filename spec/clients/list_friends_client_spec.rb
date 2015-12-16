require 'rails_helper'

describe ListFriendsClient do
	
	context "#get_all_friends" do
		it "should throw an exception if user is not signed in" do
			client = ListFriendsClient.new
			expect { client.get_all_friends }.to raise_exception("user not signed in") 
		end

		it "should call my friends endpoint if user is signed in" do
			client = ListFriendsClient.new
			
			response = double()

			allow(Authorizable).to receive(:signed_in?).and_return(true)
            allow(response).to receive(:body).and_return("body")

			expect(RestClient::Request).to receive(:execute).with(hash_including(url: /me/)).and_return(response)
			client.get_all_friends
		end
	end	
end