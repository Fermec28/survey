require 'rails_helper'
require 'byebug'

RSpec.describe "Api::V1::Auths", type: :request do
  let!(:user) { create(:fer_user) }
  let!(:other_user) { create(:user, password: "test", password_confirmation: "test") }


  describe "POST /api/v1/login" do
    it "returns http success" do
      payload = {
        user:{
          email: user.email,
          password: "test"
        }
      }
      post "/api/v1/login", params:payload
      expect(response).to have_http_status(:success)
      payload = JSON.parse(response.body)
      token = payload["Authorization"]      
      auth_headers = {
        'Authorization' => "Bearer #{token}"
      }     
      get "/api/v1/is_authenticated", headers: auth_headers 
      expect(response).to have_http_status(:success)    
    end
  end
end
