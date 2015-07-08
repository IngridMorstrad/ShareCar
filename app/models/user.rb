class User < ActiveRecord::Base
    has_many :owner
    has_many :passenger
    has_many :loan
	attr_accessor :password
	validates_confirmation_of :password
    validates :name,  presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
    before_create :create_auth_token
    before_save :encrypt_password, :downcase_email
    after_save :clear_password

    def self.authenticate(email, password)
        user = User.find_by_email(email)
        if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
            user
        else
            nil
        end
    end

    def is_activated?
        self.activated
    end

    def activate(token)
        if self.auth_token == token
            self.activated = true
            self.activated_at = Time.zone.now
            save!
            true
        else
            false
        end
    end

    def send_activation_email
        UserMailer.welcome_email(self).deliver
    end

    def send_password_reset
        create_password_reset_token
        self.password_reset_sent_at = Time.zone.now
        save!
        UserMailer.password_reset(self).deliver
    end

    private

    def downcase_email
        self.email = email.downcase
    end
    
    def encrypt_password
        if password.present?
    	   self.password_salt = BCrypt::Engine.generate_salt
    	   self.password_hash = BCrypt::Engine.hash_secret(password, self.password_salt)
        end
    end

    def clear_password
        password = nil
    end

    def create_password_reset_token
        generate_token(:password_reset_token)
    end

    def create_auth_token
        generate_token(:auth_token)
    end

    def generate_token(column)
        begin
            self[column] = SecureRandom.urlsafe_base64
        end while User.exists?(column => self[column])
    end
end
