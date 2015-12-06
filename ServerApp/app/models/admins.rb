class Admins < ActiveRecord::Base
	self.table_name = "admin"
	has_secure_password
end
