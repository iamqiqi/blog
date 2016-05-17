class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable, :confirmable,
	:recoverable, :rememberable, :trackable, :validatable

	has_many :comments, through: :articles
	has_many :articles
	has_many :active_relationships, class_name: "Relationship",
									foreign_key: "follower_id",
									dependent: :destroy
	has_many :passive_relationships, class_name: "Relationship",
									foreign_key: "followee_id",
									dependent: :destroy
	has_many :following, through: :active_relationships, source: :followee
	has_many :followers, through: :passive_relationships, source: :follower

	attr_accessor :login

	validates :username,
	:presence => true,
	:uniqueness => {
		:case_sensitive => false
	}
	validates_format_of :username, with: /\A[a-zA-Z0-9_]*\z/

	def self.find_for_database_authentication(warden_conditions)
		conditions = warden_conditions.dup
		if login = conditions.delete(:login)
			where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
		else
			conditions[:email].downcase! if conditions[:email]
			where(conditions.to_hash).first
		end
	end

	def to_param
		username
	end

	# Follows a user.
	def follow(other_user)
		active_relationships.create(followee_id: other_user.id)
	end

	# Unfollows a user.
	def unfollow(other_user)
		active_relationships.find_by(followee_id: other_user.id).destroy
	end

	# Returns true if the current user is following the other user.
	def following?(other_user)
		following.include?(other_user)
	end

	def followers?(other_user)
		passive_relationships.include?(other_user)
	end
end
