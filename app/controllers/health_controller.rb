class HealthController < ApplicationController
    def health
        render json:"OK", status: :ok
    end
end