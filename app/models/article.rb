class Article < ActiveRecord::Base
	include PublicActivity::Common

	has_many :comments, dependent: :destroy
	belongs_to :user
	validates :title, presence: true, length: { minimum: 5 }
end
