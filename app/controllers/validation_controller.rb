class ValidationController < ActionController::API
    
    def email_available
        email = params[:email]
        if email
            available = User.where(email: email).count < 1
            render json: {available: available}
        else
            render json: {error: "Favor informar email"}
        end
    end

end
