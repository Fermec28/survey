class Api::V1::SurveysController < ApplicationController
  include Secured
  before_action :authenticate_user! , only: [:index, :create, :destroy, :update]
  before_action :option_authenticate!, only: [:show]

  def index
    @surveys = Current.user.surveys.all
    render json: @surveys, status: :ok
  end

  def create
    @survey = Current.user.surveys.create!(survey_params)
    render json: @survey, status: :created
  end

  def show
    unless Current.user
      @survey = Survey.find(params[:id])
      render json: @survey
    else
      @survey = Current.user.surveys.find(params[:survey_id])
      render json: @survey, serializer: SurveyStatisticSerializer, status: :ok
    end
  end

  def destroy
      survey = Current.user.surveys.find(params[:id])
      survey.destroy
      render json: {} , status: :no_content
  end


  def update
    @survey = Current.user.surveys.find(params[:id])
    @survey.update(survey_params)
    render json: @survey, status: :ok
  end

  private

  def survey_params
    params.require(:survey).permit(:description)
  end
end
