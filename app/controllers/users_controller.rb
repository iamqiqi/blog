class UsersController < ApplicationController
	#before_action :authenticate_user!, only: [:follow, :unfollow]

	def index
		@users = User.all
	end

	def show
		@user = User.find_by_username(params[:username])
		@articles = @user.articles
	end

	def update
		current_user.bio = params[:user][:bio]
		current_user.save
		redirect_to :back
	end

	def follow
		@user = User.find_by_username(params[:username])

		if !current_user
			session[:user_return_to] = request.referer || user_path(@user)
			authenticate_user!
		else
			current_user.active_relationships.create(followee: @user)
			redirect_to :back
		end
	end

	def unfollow
		@user = User.find_by_username(params[:username])

		if !current_user
			session[:user_return_to] = request.referer || user_path(@user)
			authenticate_user!
		else
			current_user.active_relationships.find_by(followee: @user).destroy
			redirect_to :back
		end
	end

	def followers
		@user = User.find_by_username(params[:username])
		@followers = @user.followers
	end

	def following
		@user = User.find_by_username(params[:username])
		@following = @user.following
	end
end
