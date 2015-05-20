class ExamsController < ApplicationController
  load_and_authorize_resource

  def index
    @list_exams = current_user.exams.order_time.paginate page: params[:page],
                                                per_page: Settings.per_page
    @categories = Category.all
    @exam = current_user.exams.build
  end

  def show
    @exam = Exam.find params[:id]
  end

  def create
    if params[:exam]
      @exam = current_user.exams.build exam_params
      if @exam.save
        flash[:success] = I18n.t "notice.exam_create"
        redirect_to root_path
      else
        flash[:danger] = I18n.t "notice.exam_fail"
        redirect_to root_path
      end
    else
      flash[:danger] = I18n.t "notice.exam_fail"
      redirect_to root_path
    end
  end

  def edit
    @exam = Exam.find params[:id]
    @results = @exam.results
    if @exam.done?
      flash[:danger] = I18n.t "notice.done_exam"
      redirect_to root_path
    elsif @exam.start_time.nil?
      @exam.update_start_time
    end
  end

  def update
    @exam = Exam.find params[:id]
    if @exam.update_attributes exam_params
      flash[:success] = I18n.t "notice.submit_exam"
      redirect_to root_path
    else
      flash[:danger] = I18n.t "notice.fail_to_submit"
      render "edit"
    end
  end

  private
  def exam_params
    params.require(:exam).permit :category_id, results_attributes:
      [:id, :question_id, :answer_id]
  end
end
