
class Api::V1::ResponsesController < ApplicationController
  include Secured
  before_action :option_authenticate! , only: [:create]
  before_action :get_option


  def create
    unless Current.user
      @option.responses.create()
      return render json: {}, status: :ok      
    end
    render json: {}, status: :unauthorized
  end
  private 
    
  def get_option
    @option =  Option.find(params[:option_id])
  end
end
