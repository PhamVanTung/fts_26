class User < ActiveRecord::Base
  has_many :exams, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
