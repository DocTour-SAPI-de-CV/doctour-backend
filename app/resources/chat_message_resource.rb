class ChatMessageResource < JSONAPI::Resource
  attributes :message, :readed, :created_at, :updated_at
  filter :new, apply: ->(records, value, options) {
                 #falta tratar o value
                 #vou copiar a função que fiz no stethum
                 current_user = options[:context][:current_user]
                 current_user.received_messages
                   .where(readed: false)
               }
  has_one :to, class_name: "ChatContact"
  has_one :from, class_name: "ChatContact"
  before_update do
    if ChatMessage.find(@model.id).readed == true
      throw :abort
    else
      # no caso de no bd ja estar falso e querer setar como falso tbm
      if @model.readed == false
        throw :abort
      end
    end
  end
  def self.records(options = {})
    current_user = options[:context][:current_user]
    current_user.sended_messages.or current_user.received_messages
  end

  def self.updatable_fields(context)
    [:readed]
  end
end
