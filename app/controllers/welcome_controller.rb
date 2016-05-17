class WelcomeController < ApplicationController
	def newsfeed
		if current_user
			@newFolowers = PublicActivity::Activity.where(recipient_id: current_user.id, key: 'relationship.create').order('created_at DESC')
			@FolloweeArticles = PublicActivity::Activity.where(recipient_id: current_user.id, key: 'article.new').order('created_at DESC')
			@FolloweeComments = PublicActivity::Activity.where(recipient_id: current_user.id, owner_id: !current_user.id, key: 'comment.new').order('created_at DESC')
		else
			render 'index'
		end
	end

	def index
	end
end
