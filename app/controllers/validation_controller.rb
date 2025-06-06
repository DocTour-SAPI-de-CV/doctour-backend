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

    def document_valid
        document_type = params[:document_type]
        number = params[:number]
        doc = Document.new document_type: document_type, number: number
        valid = doc.valid?
        
        render json: {valid: valid, errors: doc.errors.messages}
    end


end
