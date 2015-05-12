class User < ActiveRecord::Base
  mount_uploader :avatar, PictureUploader

  before_save {self.email = email.downcase}
  
  has_many :exams, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: false}
  validates :password, length: {minimum: 6}, allow_blank: true
  validate  :avatar_size

  private
  def avatar_size
    if avatar.size > 5.megabytes
      errors.add :avatar, "should be less than 5MB"
    end
  end
end
