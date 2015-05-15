class Question < ActiveRecord::Base
  belongs_to :category
  has_many :answers, dependent: :destroy
  has_many :results, dependent: :destroy

  scope :random_questions, ->{limit(Settings.num_of_questions).order "RANDOM()"}
  accepts_nested_attributes_for :answers, allow_destroy: true

  validates :category_id, presence: true
  validates :content, presence: true, length: {maximum:20}

  scope :filter_category, ->category_id {where category_id: category_id if category_id.present?}
end
