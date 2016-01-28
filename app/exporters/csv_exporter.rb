require 'csv'

class CSVExporter < Exporter
	
	def export_friends(input = [], users_list = [])
		CSV.generate do |csv|
			csv << ["friend_name","friend_email"]
			input.each do |entry|
				line = []
				line << return_correct_name(entry,users_list)
				line << get_email_by_id(entry[:userRequested.to_s],users_list)
 				csv << line
			end
		end
	end

	private
	def return_correct_name(entry,users_list)
		if entry[:userRequested.to_s].size < 3
			get_username_by_id(entry[:userRequested.to_s],users_list)
		else
			"foo"
		end
	end
end