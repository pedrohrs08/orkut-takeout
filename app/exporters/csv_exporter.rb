require 'csv'

class CSVExporter
	
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

	private
	def get_username_by_id(id,users = [])
		get_property_from_user(id,users,:name)
	end

	def get_email_by_id(id,users = [])
		get_property_from_user(id,users,:email)
	end

	def get_property_from_user(id,users = [], property)
		 users.select { |u| u[:_id] == id }.collect{ |e| e[property] }.first 
	end
end