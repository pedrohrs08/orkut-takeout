class JSONExporter 
	
	FRIENDLY = "Friendly"
	NOT_SO_FRIENDLY = "Not So Friendly"
	SUPER_FRIENDLY = "Super Friendly"

	def export_friends(input = [], user = {})
		    
		    socialPercentageNumber = get_social_percentage(input.size)
		    socialTypeText = get_social_type(socialPercentageNumber)

			json = JSONBuilder::Compiler.generate do
		    	count input.size
		    	
		    	user user do |user|
		    		name user[:name.to_s]
		    		email user[:email.to_s]
		            socialPercentage socialPercentageNumber.to_s + "%"
		            socialType socialTypeText
		    	end

		    	friends input do |entry|
		    		name entry[:user.to_s][:name.to_s] 
		    		email entry[:user.to_s][:email.to_s]
		    	end

		    end
		    json
	end

	private 
	def get_social_percentage(friends_count)
		(friends_count * 100) / 15
	end

	def get_social_type(social_percentage)
		if social_percentage > 80
			return SUPER_FRIENDLY
		elsif social_percentage > 30
			return FRIENDLY
		else
			return NOT_SO_FRIENDLY
		end 			
	end
end