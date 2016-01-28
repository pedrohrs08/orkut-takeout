class JSONexporter < Exporter
	def export_friends(input = [], users_list = [])
			json = JSONBuilder::Compiler.generate do
		    	count input.size
		    	friends input do |entry|
		    		friendName get_username_by_id(entry[:vipUserRequested.to_s],users_list) 
		    		friendEmail get_email_by_id(entry[:vipUserRequested.to_s],users_list)
		    	end
		    end
		    json
	end
end