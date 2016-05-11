class UserPolicy
	attr_reader :logged_in_user, :user

	def initialize(logged_in_user, user)
		@user = user
		@logged_in_user = logged_in_user
	end

	def edit?
		@user == @logged_in_user
	end

	def account_settings?
		edit?
	end

	def profile?
		edit?
	end

	def articles?
		edit?
	end
end
