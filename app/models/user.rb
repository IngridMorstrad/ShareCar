class User < ActiveRecord::Base
    has_many :owner
    has_many :passenger
    has_many :loan
	attr_accessor :password
	validates_confirmation_of :password
    validates :name,  presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
    before_save :encrypt_password
    def encrypt_password
    	self.password_salt = BCrypt::Engine.generate_salt
    	self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
    def self.authenticate(email, password)
    	user = User.where(email: email).first
    	if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
    		user
    	else
    		nil
    	end
    end
end
