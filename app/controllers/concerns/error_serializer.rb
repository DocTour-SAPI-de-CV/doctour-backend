# frozen_string_literal: true

module ErrorSerializer
  def field_error(field, title = '', detail = '')
    {
      title: title,
      detail: detail,
      source: { path: field }
    }
  end

  def errors(errors)
    { errors: errors }
  end
end
