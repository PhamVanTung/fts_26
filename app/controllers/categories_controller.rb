class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = Category.paginate page: params[:page], per_page: Settings.per_page
  end
end
