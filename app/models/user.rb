class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	:recoverable, :rememberable, :trackable, :validatable

	has_many :comments, through: :articles
	has_many :articles

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
end
