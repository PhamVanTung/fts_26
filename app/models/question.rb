class Question < ActiveRecord::Base
  belongs_to :category
  has_many :answers, dependent: :destroy
  has_many :results, dependent: :destroy

  scope :random_questions, ->{limit(Settings.num_of_questions).order "RANDOM()"}
end
