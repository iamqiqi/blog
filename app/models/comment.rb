class Comment < ActiveRecord::Base
	include PublicActivity::Model
	tracked owner: Proc.new{ |controller, model| controller.current_user }

	belongs_to :article
	belongs_to :user
end
