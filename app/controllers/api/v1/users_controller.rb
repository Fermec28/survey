class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      payload = {user_id: user.id}
      token  = TokenValidationService.encode(payload)
      render json: {Authorization: token}.merge(user.slice(:id, :email)) ,status: :created
    else
      render json: {errors: user.errors.full_messages}, status: :not_acceptable
    end
  end

  private

  def user_params
    params.require(:user).permit( :email, :password, :password_confirmation)
  end
end
