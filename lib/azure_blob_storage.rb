# frozen_string_literal: true  
  
require 'azure/storage/blob'  
  
class AzureBlobStorage  
  def initialize  
    @client = Azure::Storage::Blob::BlobService.create(  
      storage_account_name: ENV.fetch('AZURE_STORAGE_ACCOUNT'),  
      storage_access_key: ENV.fetch('AZURE_STORAGE_ACCESS_KEY')  
    )  
    @container_name = ENV.fetch('AZURE_STORAGE_CONTAINER_NAME', 'doctour-files')  
  end  
  
  def upload(file, file_path)  
    # Ensure container exists  
    @client.create_container(@container_name, public_access_level: 'blob')  
      
    # Upload file  
    @client.create_block_blob(  
      @container_name,  
      file_path,  
      file.tempfile  
    )  
  
    # Return public URL  
    get_url(file_path)  
  end  
  
  def delete(file_path)  
    @client.delete_blob(@container_name, file_path)  
  end  
  
  def get_url(file_path)  
    "https://#{ENV.fetch('AZURE_STORAGE_ACCOUNT')}.blob.core.windows.net/#{@container_name}/#{file_path}"  
  end  
end
