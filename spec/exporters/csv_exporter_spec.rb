require 'rails_helper'

describe CSVExporter do
    
	    let(:friends_json) do 
	    	JSON.parse(%Q{[{"_id":"56ab7fc22e481306042c151d","user":{"_id":"56ab7ee72e481306042c1518","name":"QA Couse User 1","email":"qacourseuser1@avenuecode.com"}},{"_id":"56ab7fd22e481306042c151e","user":{"_id":"56ab7ef12e481306042c1519","name":"QA Couse User 2","email":"qacourseuser2@avenuecode.com"}},{"_id":"56ab7fd82e481306042c151f","user":{"_id":"56ab7efb2e481306042c151a","name":"QA Couse User 3","email":"qacourseuser3@avenuecode.com"}},{"_id":"56ab7fe22e481306042c1520","user":{"_id":"56ab7f042e481306042c151b","name":"QA Couse User 4","email":"qacourseuser4@avenuecode.com"}},{"_id":"56ab7fec2e481306042c1521","user":{"_id":"56ab7f102e481306042c151c","name":"QA Couse User 5","email":"qacourseuser5@avenuecode.com"}}]})	    	
        end

        let(:user_json) do 
			JSON.parse(%Q{{"_id":"56608bd7edd9adc72c1b48ee","provider":"local","name":"Pedro","email":"pedrohrs08@gmail.com","password":"081289","__v":0,"role":"user"}})
        end
    
    context "#export_friends" do 
		it "should export based on the correct json" do
	         csv_exporter = CSVExporter.new 
	         export_result = csv_exporter.export_friends(friends_json,user_json)

	         expect(export_result).to start_with("my_name,my_email,friend_name,friend_email\n")
	         expect(export_result.split("\n").size).to eq 6
	         expect(export_result).to include("QA Couse User 1,qacourseuser1@avenuecode.com")
	         expect(export_result).to include("QA Couse User 2,qacourseuser2@avenuecode.com")
		end
	end
end