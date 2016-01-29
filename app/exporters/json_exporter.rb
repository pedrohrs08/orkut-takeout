class JSONExporter 
	def export_friends(input = [], user = {})
			json = JSONBuilder::Compiler.generate do
		    	count input.size
		    	
		    	user user do |user|
		    		name user[:name.to_s]
		    		email user[:email.to_s]
		    	end

		    	friends input do |entry|
		    		name entry[:user.to_s][:name.to_s] 
		    		email entry[:user.to_s][:email.to_s]
		    	end

		    end
		    json
	end
end