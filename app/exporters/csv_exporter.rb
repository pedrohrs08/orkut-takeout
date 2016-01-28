require 'csv'

class CSVExporter < Exporter
	
	def export_friends(input = [], users_list = [])
		CSV.generate do |csv|
			csv << ["friend_name","friend_email"]
			input.each do |entry|
				line = []
				line << get_username_by_id(entry[:vipUserRequested.to_s],users_list)
				line << get_email_by_id(entry[:vipUserRequested.to_s],users_list)
 				csv << line
			end
		end
	end
end