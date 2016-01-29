class FirstSocialMediaController < ApplicationController
	def export
		raise "User missing" if params[:user].nil? and params[:password].nil?
		orkut_client = OrkutClient.new
		
		orkut_client.sign_in(params[:user],params[:password])
		
		friends_list = orkut_client.get_my_friends
		users_list = orkut_client.get_current_user_info
		
		csv_exporter = CSVExporter.new
		render text: csv_exporter.export_friends(friends_list,users_list)
	end
end