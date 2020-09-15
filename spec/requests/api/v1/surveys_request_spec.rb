require 'rails_helper'

RSpec.describe "Api::V1::Surveys", type: :request do
  
  context "Authenticated user" do
    let!(:user) { create(:user) }
    let!(:other_user) { create(:user) }
    let!(:auth_headers) {{'Authorization' => "Bearer #{TokenValidationService.encode({user_id: user.id})}"}}
    let!(:other_auth_headers) {{'Authorization' => "Bearer #{TokenValidationService.encode({user_id: other_user.id})}"}}
    let!(:surveys) { create_list(:survey, 10,  user_id: user.id) }
    let!(:survey) {create(:survey, user_id: user.id)}
    

    describe "POST /surveys" do
      it "returns http success" do
        payload = {survey: { description: "Description"}}
        post "/api/v1/surveys/", params: payload, headers: auth_headers
        expect(response).to have_http_status(:success)
      end
    end
  
    describe "DESTROY /surveys" do
      it "returns http no content" do
        delete "/api/v1/surveys/#{survey.id}", headers: auth_headers
        expect(response).to have_http_status(:no_content)
      end
    end
  
    describe "GET /surveys" do
      it "returns http success" do
        get "/api/v1/surveys/", headers: auth_headers
        expect(response).to have_http_status(:success)
      end
    end
  
    describe "PUT /surveys" do
      it "returns http success" do
        payload = {survey: { description: "fer"}}
        put "/api/v1/surveys/#{survey.id}", params: payload, headers: auth_headers
        response_payload = JSON.parse(response.body)
        expect(response).to have_http_status(:success)
        expect(response_payload["description"]).to eq(payload[:survey][:description])
      end
    end

    context "accesing to not owner resources" do
      describe "DESTROY /surveys" do
        it "returns http no content" do
          delete "/api/v1/surveys/#{survey.id}", headers: other_auth_headers
          expect(response).to have_http_status(:not_found)
        end
      end

      describe "PUT /surveys" do
        it "returns http success" do
          payload = {survey: { description: "fer"}}
          put "/api/v1/surveys/#{survey.id}", params: payload, headers: other_auth_headers
          response_payload = JSON.parse(response.body)
          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end


  context "Not Authenticated user" do
    let!(:user) { create(:user) }
    let!(:survey) {create(:survey, user_id: user.id)}
        describe "POST /surveys" do
      it "returns http success" do
        payload = {survey: { description: "Description"}}
        post "/api/v1/surveys/", params: payload
        expect(response).to have_http_status(:unauthorized)
      end
    end
  
    describe "DESTROY /surveys" do
      it "returns http no content" do
        delete "/api/v1/surveys/#{survey.id}"
        expect(response).to have_http_status(:unauthorized)
      end
    end
  
    describe "GET /surveys" do
      it "returns http success" do
        get "/api/v1/surveys/"
        expect(response).to have_http_status(:unauthorized)
      end
    end
  
    describe "PUT /surveys" do
      it "returns http success" do
        payload = {survey: { description: "fer"}}
        put "/api/v1/surveys/#{survey.id}", params: payload
        response_payload = JSON.parse(response.body)
        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe "GET /surveys/show" do
      it "returns http success" do
        get "/api/v1/surveys/#{survey.id}"
        response_payload = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
      end
    end    
  end

end
