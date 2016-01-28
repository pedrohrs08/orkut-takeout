class XMLExporter < Exporter
	def export_friends(input = [], users_list = [])
		builder = Nokogiri::XML::Builder.new do |xml|
			xml.friends_list do
				input.each do |entry|
					xml.friendName get_username_by_id(entry[:userRequested.to_s],users_list)
					xml.friendEmail get_email_by_id(entry[:userRequested.to_s],users_list)
				end
			end
		end
		builder.to_xml
	end
end