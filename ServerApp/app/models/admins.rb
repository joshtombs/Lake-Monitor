class Admins < ActiveRecord::Base
	self.table_name = "Admin"
	has_secure_password
end
