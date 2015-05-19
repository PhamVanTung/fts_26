class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :finders]

  enum role: [:admin, :normal]

  mount_uploader :avatar, PictureUploader

  before_save :update_email_role
  
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

  def slug_candidates
    [
      :name,
      [:name, :id]
    ]
  end

  private
  def avatar_size
    if avatar.size > 5.megabytes
      errors.add :avatar, "should be less than 5MB"
    end
  end

  def update_email_role
    self.email = email.downcase
    self.normal! if role.nil?
  end

  def self.send_mail
    User.all.each {|user| UserMailer.notice_exam(user).deliver_now}
  end
end
