class Admin::QuestionsController < ApplicationController
  before_action :authenticate_user!, :require_admin

  def index
    @categories = Category.all
    @q = Question.ransack(params[:q])
    @questions = @q.result(distinct: true).paginate page: params[:page], per_page: Settings.per_page
  end

  def new
    @categories = Category.all
    @question = Question.new
    Settings.default_number_answer.times{@question.answers.build}
  end

  def create
    @question = Question.new question_params
    if @question.save
      flash[:success] = I18n.t "notice.question_create"
      redirect_to admin_questions_path
    else
      @categories = Category.all
      render "new"
    end
  end

  def edit
    @categories = Category.all
    @question = Question.find params[:id]
    @answers = @question.answers
  end

  def update
    @question = Question.find params[:id]
    if @question.update_attributes question_params
      flash[:success] = I18n.t "notice.question_update"
      redirect_to admin_questions_path
    else
      @categories = Category.all
      render "edit"
    end
  end

  def destroy
    Question.find(params[:id]).destroy
    respond_to do |format|
      format.html {redirect_to categories_path}
      format.js
    end
  end

  private
  def question_params
    params.require(:question).permit :content, :category_id, 
      answers_attributes: [:id, :content, :correct, :_destroy]
  end
end
