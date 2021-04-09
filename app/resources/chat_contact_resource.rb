class ChatContactResource < JSONAPI::Resource
  model_name "User"
  attributes :email, :created_at, :updated_at

  def self.records(options = {})
    current_user = options[:context][:current_user]
    if current_user.account.category == "patient"
      # apenas usuarios que recebeu as mensagens
      User.joins(:received_messages).where("chat_messages.to_id = ?", current_user.id).distinct.all
    else
      User.includes(account: [people: [:patient]]).references(:accounts).where("accounts.category = ?", :patient)
    end
  end
end
