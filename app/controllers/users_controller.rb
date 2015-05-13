class UsersController < ApplicationController
  load_and_authorize_resource

  def show
    @user = User.find params[:id]
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]
    if @user.update_attributes user_params
      flash[:success] = I18n.t 'notice.update_user'
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
                          :password_confirmation, :avatar
  end
end
