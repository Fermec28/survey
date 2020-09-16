require 'rails_helper'

RSpec.describe "options", type: :request do
  context "Nested Route Report Question " do 
    let!(:user) { create(:user) }
    let!(:other_user) { create(:user) }
    let!(:auth_headers) {{'Authorization' => "Bearer #{TokenValidationService.encode({user_id: user.id})}"}}
    let!(:other_auth_headers) {{'Authorization' => "Bearer #{TokenValidationService.encode({other_user_id: user.id})}"}}
    let!(:survey) {create(:survey, user_id: user.id)}
    let!(:question) {create(:question, survey_id: survey.id)}

    describe "POST /api/v1/questions/question_id/options" do
      it "returns http success" do
        payload = {option: { description: "fer"}}
        post "/api/v1/questions/#{question.id}/options", params: payload, headers: auth_headers
        response_payload = JSON.parse(response.body)
        expect(response_payload).to_not be_empty
        expect(response_payload["description"]).to eq(payload[:option][:description])
        expect(response).to have_http_status(:success)
      end
    end
  
    describe "PUT /api/v1/questions/question_id/options/option_id" do
      let!(:other_option) {create(:option, question_id: question.id)}
      it "returns http success" do        
        payload = {option: { description: "fer"}}
        put "/api/v1/questions/#{question.id}/options/#{other_option.id}", params: payload, headers: auth_headers
        response_payload = JSON.parse(response.body)
        expect(response_payload).to_not be_empty
        expect(response_payload["description"]).to eq(payload[:option][:description])
        expect(response).to have_http_status(:success)
      end
    end

    describe "DELETE /api/v1/questions/question_id/options/option_id" do
      let!(:other_option) {create(:option, question_id: question.id)}
      it "returns http success" do        
        delete  "/api/v1/questions/#{question.id}/options/#{other_option.id}",  headers: auth_headers
        expect(response).to have_http_status(:no_content)
      end
    end    
  end
end