require 'csv'

class CSVExporter 
	
	def export_friends(input = [], user = {})
		CSV.generate do |csv|
			csv << ["my_name","my_email","friend_name","friend_email"]
			input.each do |entry|
				line = []
				line << user[:name.to_s]
				line << user[:email.to_s]
				line << entry[:user.to_s][:name.to_s]
				line << entry[:user.to_s][:email.to_s]
 				csv << line
			end
		end
	end
end