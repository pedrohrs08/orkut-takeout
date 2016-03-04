require 'rails_helper'

describe OrkutClient do

   let(:orkut_client) { OrkutClient.new }

   it "should perform login with valid credentials" do
   	    token = orkut_client.sign_in("pedrohrs08@gmail.com","081289")
        expect(token).to_not be_nil
        expect(Authorizable).to be_signed_in
   end
   
   it "should not perform login with invalid credentials" do 
       expect { client.sign_in("invalid@invalid.com","invalid") }.to raise_error(Exception)
   end
end