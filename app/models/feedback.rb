class Feedback < ApplicationRecord
  enum message_type: { contact: 0, suggestion: 1 }
end
