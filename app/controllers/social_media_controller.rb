class SocialMediaController < ApplicationController
	def export
		raise "User missing" if params[:user].nil? and params[:password].nil?
		sign_in_client = SignInClient.new
		sign_in_client.sign_in(params[:user],params[:password])

		friends_client = ListFriendsClient.new
		friends_list = friends_client.get_all_friends

		users_client = UsersClient.new
		users_list = users_client.get_all_users
		
		csv_exporter = CSVExporter.new
		render text: csv_exporter.export_friends(friends_list,users_list)
	end
end