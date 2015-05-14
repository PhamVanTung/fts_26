class Admin::CategoriesController < ApplicationController
  before_action :require_admin, :authenticate_user!
  def index
    @categories = Category.paginate page: params[:page], per_page: Settings.per_page
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = I18n.t 'notice.category_new'
      redirect_to admin_categories_path
    else
      render "new"
    end
  end

  def edit
    @category = Category.find params[:id]
  end

  def update
    @category = Category.find params[:id]
    if @category.update_attributes category_params
      flash[:success] = I18n.t 'notice.category_update'
      redirect_to admin_categories_path
    else
      render "edit"
    end
  end

  def destroy
    Category.find(params[:id]).destroy
    respond_to do |format|
      format.html {redirect_to admin_categories_path}
      format.js
    end
  end

  private

  def category_params
    params.require(:category).permit :name
  end
end
