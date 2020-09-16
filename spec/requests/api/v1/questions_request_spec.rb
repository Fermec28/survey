require 'rails_helper'

RSpec.describe "Questions", type: :request do
  context "Nested Route Report Question " do 
    let!(:user) { create(:user) }
    let!(:other_user) { create(:user) }
    let!(:auth_headers) {{'Authorization' => "Bearer #{TokenValidationService.encode({user_id: user.id})}"}}
    let!(:other_auth_headers) {{'Authorization' => "Bearer #{TokenValidationService.encode({other_user_id: user.id})}"}}
    let!(:survey) {create(:survey, user_id: user.id)}


    describe "POT /api/v1/surveys/survey_id/questions" do
      it "returns http success" do
        payload = {question: { description: "fer"}}
        post "/api/v1/surveys/#{survey.id}/questions", params: payload, headers: auth_headers
        response_payload = JSON.parse(response.body)
        expect(response_payload).to_not be_empty
        expect(response_payload["description"]).to eq(payload[:question][:description])
        expect(response).to have_http_status(:success)
      end
    end
  
    describe "PUT /api/v1/surveys/survey_id/questions/question_id" do
      let!(:other_question) {create(:question, survey_id: survey.id)}
      it "returns http success" do        
        payload = {question: { description: "fer"}}
        put "/api/v1/surveys/#{survey.id}/questions/#{other_question.id}", params: payload, headers: auth_headers
        response_payload = JSON.parse(response.body)
        expect(response_payload).to_not be_empty
        expect(response_payload["description"]).to eq(payload[:question][:description])
        expect(response).to have_http_status(:success)
      end
    end

    describe "DELETE /api/v1/surveys/survey_id/questions/question_id" do
      let!(:other_question) {create(:question, survey_id: survey.id)}
      it "returns http success" do        
        delete  "/api/v1/surveys/#{survey.id}/questions/#{other_question.id}",  headers: auth_headers
        expect(response).to have_http_status(:no_content)
      end
    end

    context "Access from not owner survey" do
      describe "POT /api/v1/surveys/survey_id/questions" do
        it "returns http success" do
          payload = {question: { description: "fer"}}
          post "/api/v1/surveys/#{survey.id}/questions", params: payload, headers: other_auth_headers
          expect(response).to have_http_status(:not_found)
        end
      end

      describe "PUT /api/v1/surveys/survey_id/questions/question_id" do
        let!(:other_question) {create(:question, survey_id: survey.id)}
        it "returns http success" do        
          payload = {question: { description: "fer"}}
          put "/api/v1/surveys/#{survey.id}/questions/#{other_question.id}", params: payload, headers: other_auth_headers
          expect(response).to have_http_status(:not_found)
        end
      end

      describe "DELETE /api/v1/surveys/survey_id/questions/question_id" do
        let!(:other_question) {create(:question, survey_id: survey.id)}
        it "returns http success" do        
          delete  "/api/v1/surveys/#{survey.id}/questions/#{other_question.id}",  headers: other_auth_headers
          expect(response).to have_http_status(:not_found)
        end
      end    
    end
  end
end
