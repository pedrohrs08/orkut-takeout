class XMLExporter

    BEGINNER = "BEGINNER"
    FRIENDLY = "FRIENDLY"
    PARTY_ANIMAL = "PARTY ANIMAL" 

	def export_friends(input = [], user = {})
		builder = Nokogiri::XML::Builder.new do |xml|
			xml.user do 
				xml.name user[:name.to_s]
				xml.email user[:email.to_s]
				xml.socialType get_social_type(input.size)
				xml.friends do
				  input.each do |entry|
					xml.friend do 
						xml.name entry[:user.to_s][:name.to_s]
						xml.email entry[:user.to_s][:email.to_s]
					end
				end
			end
			end
		end
		builder.to_xml
	end

	private 
	def get_social_type(number_of_friends)
		if number_of_friends < 5
			return BEGINNER
		elsif number_of_friends < 10
			return FRIENDLY
		else
			return PARTY_ANIMAL
		end
	end
end