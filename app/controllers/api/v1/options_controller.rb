class Api::V1::OptionsController < ApplicationController
  include Secured
  before_action :authenticate_user! , only: [:create, :destroy, :update]
  before_action :get_question
  
  def create
    @option = @question.options.create!(option_params)
    render json: @option
  end

  def update
    @option =  @question.options.find(params[:id])
    @option.update(option_params)
    render json: @option
  end

  def destroy
    option =  @question.options.find(params[:id])
    option.destroy
    render json: {}, status: :no_content
  end

  private 
  def option_params
    params.require(:option).permit(:description)
  end
  
  def get_question
    @question =  Question.find(params[:question_id])
  end
end
