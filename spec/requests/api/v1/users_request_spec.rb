require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do

  describe "POST /users" do
    it "returns http 201 status code" do
      payload = {
        user: {
          email: "test@test.com",
          password: "test", 
          password_confirmation: "test"
        }
      }
      post "/api/v1/users", params: payload
      response_payload = JSON.parse(response.body)
      expect(response_payload).to_not be_empty
      expect(response_payload["email"]).to eq(payload[:user][:email])
      expect(response_payload["Authorization"]).to_not be_empty
      expect(response).to have_http_status(:created)
    end
  end

end
