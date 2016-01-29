class XMLExporter 
	def export_friends(input = [], user = {})
		builder = Nokogiri::XML::Builder.new do |xml|
			xml.user do 
				xml.name user[:name]
				xml.email user[:email]
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
end