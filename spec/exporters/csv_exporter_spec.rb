require 'rails_helper'

describe CSVExporter do
    
    let(:input_json) do 
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
    
    context "#export_friends" do 
		it "should export based on the correct json" do
	         csv_exporter = CSVExporter.new 
	         export_result = csv_exporter.export_friends(input_json,users_json)

	         expect(export_result).to start_with("friend_name,friend_email\n")
	         expect(export_result.split("\n").size).to eq 3
	         expect(export_result).to include("Pedro Silva,psilva@avenuecode.com")
	         expect(export_result).to include("Eduardo Silva,esilva@avenuecode.com")
		end
	end
end