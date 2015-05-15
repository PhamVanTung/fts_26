class Exam < ActiveRecord::Base
  enum status: [:wait, :testing, :done]

  belongs_to :user
  belongs_to :category
  has_many :results, dependent: :destroy

  validates :category_id, presence: true

  accepts_nested_attributes_for :results, allow_destroy: true

  scope :order_time, ->{order created_at: :desc}

  before_create {self.status = "wait"}
  after_create :create_result
  before_update :update_score

  def update_status_testing
    self.update_attributes status: "testing"
  end

  private
  def create_result
    @questions = Question.random_questions
    @questions.each do |q|
      Result.create(exam_id: self.id, question_id: q.id)
    end
  end

  def update_score
    self.score = results.select do |result|
    result.answer == result.answers.correct.first
    end.count
  end
end
