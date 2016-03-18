class CommentPolicy
	attr_reader :user, :comment

	def initialize(user, comment)
		@user = user
		@comment = comment
	end

	# def index?
	# 	true
	# end

	# def show?
	# 	true
	# end

	def create?
		!@user.nil?
	end

	# def new?
	# 	create?
	# end

	def update?
		@comment.user == @user
	end

	def destroy?
		@comment.user == @user or
		@comment.article.user == @user
	end
end
