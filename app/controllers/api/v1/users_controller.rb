class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def update
    render json: {status: 404, message: "User not found"} unless @user.present?

    if @user.update(update_params)
      render json: {status: 200, message: "Name updated successfully"}
    end
  end

  private

  def update_params
    params.require(:user).permit(:id, :first_name)
  end

  def set_user
    @user = current_user || User.find_by(id: params[:id])
  end
end