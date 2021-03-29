class FeedbackResource < JSONAPI::Resource
  attributes :name, :email, :message_type, :message, :title, :phone, :created_at, :updated_at
end
