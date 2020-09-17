class Api::V1::AuthController < ApplicationController
  include Secured
  before_action :authenticate_user!, only: [:user_is_authenticated]

  def login
    user = User.find_by(email: user_params[:email])
    if user && user.authenticate(user_params[:password])
        payload = {user_id: user.id}
        token = TokenValidationService.encode(payload)
        render json: {Authorization: token}.merge(user.slice(:id, :email)), status: :ok
    else
        render json: {failure: "Log in failed! Username or password invalid!"}, status: :bad_request
    end
  end

  def user_is_authenticated
    render json: {message: "You are authorized"}, status: :ok
  end

  private
  def user_params
    params.permit(:email, :password)
  end
end
