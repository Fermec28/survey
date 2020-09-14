require 'byebug'
module Secured
    def authenticate_user!
                
        headers = request.headers
        if headers['Authorization'].present? && headers['Authorization']
            if (decoded_hash = TokenValidationService.decode(headers['Authorization']))
                user_id = decoded_hash[0]['user_id']
                if(Current.user = User.find(user_id))
                    return
                end
            end
        end
        render json: {error: 'Unauthorized'}, status: :unauthorized
    end
end

