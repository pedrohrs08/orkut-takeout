require  'rails_helper'

describe XMLExporter do 
    let(:exporter) { XMLExporter.new }
    
    let(:current_user_hash){
    	 {
    	 	"_id" => "56608bd7edd9adc72c1b48ee",
   		 	"provider" => "local",
   		 	"name" => "Pedro",
   		 	"email" => "pedrohrs08@gmail.com",
   		 	"password" => "081289",
   		 	"__v" => 0,
   		 	"role" => "user"
   		 }
    }

    let(:friends_hash){
    	JSON.parse(%Q([{"_id":"56ab7fc22e481306042c151d","user":{"_id":"56ab7ee72e481306042c1518","name":"QA Couse User 1","email":"qacourseuser1@avenuecode.com"}},{"_id":"56ab7fd22e481306042c151e","user":{"_id":"56ab7ef12e481306042c1519","name":"QA Couse User 2","email":"qacourseuser2@avenuecode.com"}},{"_id":"56ab7fd82e481306042c151f","user":{"_id":"56ab7efb2e481306042c151a","name":"QA Couse User 3","email":"qacourseuser3@avenuecode.com"}},{"_id":"56ab7fe22e481306042c1520","user":{"_id":"56ab7f042e481306042c151b","name":"QA Couse User 4","email":"qacourseuser4@avenuecode.com"}},{"_id":"56ab7fec2e481306042c1521","user":{"_id":"56ab7f102e481306042c151c","name":"QA Couse User 5","email":"qacourseuser5@avenuecode.com"}}]))
    }

    let(:party_animal_friends){
    	friends_array = []
    	
    	11.times do 
           friends_array << %Q({
	                           "_id": "56ab7fc22e481306042c151d",
                            	"user": {
		                           "_id": "56ab7ee72e481306042c1518",
		                           "name": "QA Couse User 1",
		                           "email": "qacourseuser1@avenuecode.com"
	                            }
	                          })
    	end
    	friends_string = friends_array.join(",")

    	JSON.parse("[#{friends_string}]")
    }

    context "should export my friends in XML format " do 
       it "should say my social type is SOCIABLE" do
           xml_exported = exporter.export_friends(friends_hash,current_user_hash)
           xml_exported = Hash.from_xml(xml_exported)
   
           expect(xml_exported["user"]["socialType"]).to eq("FRIENDLY")
       end

        it "should say my social type is PARTY ANIMAL" do

           xml_exported = exporter.export_friends(party_animal_friends,current_user_hash)
          
           xml_exported = Hash.from_xml(xml_exported)
   
           expect(xml_exported["user"]["socialType"]).to eq("PARTY ANIMAL")
       end
    end
end
