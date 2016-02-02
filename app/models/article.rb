class Article < ActiveRecord::Base
	include PublicActivity::Model
	tracked owner: Proc.new{ |controller, model| model.user }

	has_many :comments, dependent: :destroy
	belongs_to :user
	validates :title, presence: true, length: { minimum: 5 }
end
