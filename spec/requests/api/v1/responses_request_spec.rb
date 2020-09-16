require 'rails_helper'
require 'byebug'

RSpec.describe "Api::V1::Responses", type: :request do
  let!(:user) { create(:user) }
  let!(:auth_headers) {{'Authorization' => "Bearer #{TokenValidationService.encode({user_id: user.id})}"}}
  let!(:survey) {create(:survey, user_id: user.id)}
  let!(:question) {create(:question, survey_id: survey.id)}
  let!(:option) {create(:option, question_id: question.id)}
  context "single user" do 
    describe "POST /api/v1/options/option_id/responses" do
      it "returns http success" do
        post "/api/v1/options/#{option.id}/responses"
        expect(response).to have_http_status(:success)    
      end
    end 
  end
  context "Login user" do
    describe "POST /api/v1/options/option_id/responses" do
      it "returns http success" do
        post "/api/v1/options/#{option.id}/responses", headers: auth_headers
        expect(response).to have_http_status(:unauthorized)    
      end
    end 
  end
end
