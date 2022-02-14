class MassiveUploadController < ApplicationController

    def upload_file
        
        xlsx = Roo::Excelx.new(params[:uploaded_file])
        
        arr_xlsx = Array.new

        (2..xlsx.last_row).each do |index|
            arr_xlsx.append(xlsx.row(index))
        end

        render json: arr_xlsx 
    end

end
