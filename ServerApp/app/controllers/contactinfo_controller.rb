class ContactinfoController < ApplicationController

	def index
		@contacts = Contactinfo.all
	end
	private
		def contactinfo_params
			params.require(:contactinfo).permit(:first_name, :last_name, :phone_number, :email)
		end
end