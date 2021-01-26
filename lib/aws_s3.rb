# frozen_string_literal: true

require 'aws-sdk-s3'

class AwsS3
  def self.upload(file, file_path)
    aws_access_key_id = Rails.application.credentials.aws_access_key_id
    aws_secret_access_key = Rails.application.credentials.aws_secret_access_key
    aws_region = Rails.application.credentials.aws_region

    file_name =   file_path.to_s
    upload_file = file.tempfile
    s3 = Aws::S3::Resource.new(region: aws_region, access_key_id: aws_access_key_id, secret_access_key: aws_secret_access_key)

    obj = s3.bucket('doctour').object(file_name)
    obj.upload_file(upload_file, { acl: 'public-read' })

    obj.public_url
  end
end
