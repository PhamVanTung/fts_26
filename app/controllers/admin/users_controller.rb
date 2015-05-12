class Admin::UsersController < ApplicationController
  load_and_authorize_resource
  before_action :require_admin

  def index
    @users = User.paginate page: params[:page], per_page: Settings.per_page
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]
    if @user.update_attributes user_params
      flash[:success] = I18n.t 'notice.update_user'
      redirect_to admin_users_path
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    respond_to do |format|
      format.html {redirect_to admin_users_path}
      format.js
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
                          :password_confirmation, :avatar
  end
end
