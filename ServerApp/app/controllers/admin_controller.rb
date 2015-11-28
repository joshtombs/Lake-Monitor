class AdminController < ApplicationController
	
	def login
		
	end

	private
	def admin_params
		params.require(:admin).permit(:username, :password)
	end
end