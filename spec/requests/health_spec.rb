require "rails_helper"


RSpec.describe "Health endpoint", type: :request do
    describe "GET /health" do
        before { get "/health"}

        it "should return OK" do
            payload = response.body
            expect(payload).not_to be_empty
            expect(response.body).to eq('OK')
        end

        it "should return status code 200" do
            expect(response).to have_http_status(200)
        end
    end     
end