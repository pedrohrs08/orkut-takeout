require 'rails_helper'

describe OrkutClient do
   it "#should_login" do
   	    client = OrkutClient.new
   	    token = client.sign_in("pedrohrs08@gmail.com","081289")
        expect(token).to_not be_nil
   end
end