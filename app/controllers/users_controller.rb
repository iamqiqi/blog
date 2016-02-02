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

	def edit
		@user = User.find_by_username(params[:username])
		authorize @user
	end

	def account_settings
		@user = User.find_by_username(params[:username])
		authorize @user
	end

	def profile
		@user = User.find_by_username(params[:username])
		authorize @user
	end

	def articles
		@user = User.find_by_username(params[:username])
		authorize @user
		@articles = @user.articles
	end

	def newsfeed
		@user = User.find_by_username(params[:username])
		authorize @user
		@followers = Array.new
		@keys = Array.new
		@activities = PublicActivity::Activity.where(recipient_id: current_user.id).order('created_at DESC')
		@length = @activities.length
		for i in 0..@length-1
			@user = User.find(@activities[i].owner_id)
			@keys.push(@activities[i].key)
			@followers.push(@user.username)
		end
		# @activities.each do |activity|
		# 	@user = User.find(activity.owner_id)
		# 	@keys.push(activity.key)
		# 	@followers.push(@user.username)
		# end
	end
end
