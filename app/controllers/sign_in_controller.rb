class SignInController < ApplicationController

	def index

	end

	def export
	   if params[:export] == 'social_network_1'
	   		redirect_to controller: 'first_social_media', action: 'export',  params: params
	   elsif params[:export] == 'social_network_2'
	   		redirect_to controller: 'second_social_media', action: 'export',  params: params
	   elsif params[:export] == 'social_network_3'
			redirect_to controller: 'third_social_media', action: 'export',  params: params
	   else
	   		raise ActiveRecord::RecordNotFound 
	   end
	end
end