class Exam < ActiveRecord::Base
  enum status: [:wait, :testing, :done]

  belongs_to :user
  belongs_to :category
  has_many :results, dependent: :destroy

  validates :category_id, presence: true

  accepts_nested_attributes_for :results, allow_destroy: true

  scope :order_time, ->{order created_at: :desc}

  before_save {self.status = "wait"}
  after_save :create_result

  private
  def create_result
    @questions = Question.random_questions
    @questions.each do |q|
      Result.create(exam_id: self.id, question_id: q.id)
    end
  end
end
