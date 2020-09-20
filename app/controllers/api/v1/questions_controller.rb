class Api::V1::QuestionsController < ApplicationController
  include Secured
  before_action :authenticate_user! , only: [:create, :destroy, :update, :statistics]
  before_action :get_survey
  
  def create
    @question = @survey.questions.create!(question_params)
    render json: @question
  end

  def update
    @question =  @survey.questions.find(params[:id])
    @question.update(question_params)
    render json: @question
  end

  def destroy
    question =  @survey.questions.find(params[:id])
    question.destroy
    render json: {}, status: :no_content
  end

  def statistics
    @question = @survey.questions.find(params[:question_id])
    render json: @question, serializer: QuestionStatisticSerializer, status: :ok
  end

  private 
  def question_params
    params.require(:question).permit(:description)
  end
  
  def get_survey
    @survey =  Survey.find(params[:survey_id])
  end


end
