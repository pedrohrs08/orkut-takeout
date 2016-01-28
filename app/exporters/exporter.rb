class Exporter
	protected
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