class ExamsController < ApplicationController
  def index
    @list_exams = current_user.exams.order_time.paginate page: params[:page],
                                                per_page: Settings.per_page
    @categories = Category.all
    @exam = current_user.exams.build
  end

  def create
    if params[:exam]
      @exam = current_user.exams.build exams_params
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

  private
  def exams_params
    params.require(:exam).permit :category_id, results_attributes: [:question_id]
  end
end
