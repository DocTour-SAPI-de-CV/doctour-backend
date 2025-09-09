module ApplicationHelper  
  def email_image_url(image_name)  
    if ENV.fetch('STORAGE_PROVIDER', 'aws') == 'azure'  
      # Use Azure Blob Storage with signed URLs for private access  
      azure_storage = AzureBlobStorage.new  
      azure_storage.get_signed_url("mailers/#{image_name}")  
    else  
      # Use AWS S3 public URLs  
      "#{ENV.fetch('EMAIL_IMAGES_BASE_URL')}#{image_name}"  
    end  
  end  
end
