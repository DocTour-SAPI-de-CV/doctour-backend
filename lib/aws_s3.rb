# frozen_string_literal: true

require 'aws-sdk-s3'

class AwsS3

  def self.access_codes
    aws_access_key_id = ENV['AWS_ACCESS_KEY_ID'] || 'your_aws_access_key'
    aws_secret_access_key = ENV['AWS_SECRET_ACCESS_KEY'] || 'your_aws_secret_key'
    aws_region = ENV['AWS_REGION'] || 'us-east-2'
    @s3 = Aws::S3::Resource.new(region: aws_region, access_key_id: aws_access_key_id, secret_access_key: aws_secret_access_key)
  end

  def self.upload(file, file_path)
    access_codes

    file_name =   file_path.to_s
    upload_file = file.tempfile
    obj = @s3.bucket('doctour-internal').object(file_name)
    obj.upload_file(upload_file, { acl: 'public-read' })

    obj.public_url
  end

  def self.delete(file_path)
    access_codes

    object = @s3.bucket('doctour-internal').object("#{file_path}")

    object.delete
  end
end
