class User < ActiveRecord::Base
  before_save {self.email = email.downcase}
  before_create :create_remember_token
  validates :name,presence:true,length:{maximum:50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,presence:true,format:{with:VALID_EMAIL_REGEX},uniqueness:{case_sensitive:true}
  has_secure_password
  validates :password,length:{minimum:6}

  has_many :microposts,dependent: :destroy

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.hash(token)
    if token.nil?
      nil
    else
      Digest::SHA1.hexdigest(token)
    end

  end

  private
  def create_remember_token
    self.remember_token = User.hash(User.new_remember_token)
  end

end
