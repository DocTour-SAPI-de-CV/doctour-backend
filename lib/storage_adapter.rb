# frozen_string_literal: true  
  
class StorageAdapter  
  class << self  
    def upload(file, file_path)  
      provider.upload(file, file_path)  
    end  
  
    def delete(file_path)  
      provider.delete(file_path)  
    end  
  
    def get_url(file_path)  
      provider.get_url(file_path)  
    end  
  
    private  
  
    def provider  
      @provider ||= case ENV.fetch('STORAGE_PROVIDER', 'aws')  
                    when 'aws'  
                      AwsS3  
                    when 'azure'  
                      AzureBlobStorage.new  
                    else  
                      raise "Unsupported storage provider: #{ENV['STORAGE_PROVIDER']}"  
                    end  
    end  
  end  
end
