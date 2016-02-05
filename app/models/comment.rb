class Comment < ActiveRecord::Base
	include PublicActivity::Common

	belongs_to :article
	belongs_to :user
end
