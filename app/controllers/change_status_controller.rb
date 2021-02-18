# frozen_string_literal: true

VERIFY = Register::VerificationController

class ChangeStatusController < ApplicationController
  def result(content)
    @message = content[:message]
    @status = content[:status]
  end

  def update
    user = User.find(params[:id])

    if user.account.category == 'doctor'
      @object = Doctor.find_by(person: user.account.people)

      change(params[:status])
    elsif user.account.category == 'assistant'
      @object = Assistant.find_by(person: user.account.people)

      change(params[:status])
    else
      @message = { error: 'Utilze somente para medico e assistente' }
      @status = :bad_request
    end

    render(json: @message, status: @status)
  end

  def change(status)
    @object.status = status
    @object.save!

    result(VERIFY.result({ object: @object, flag: false }))
    @message = { success: 'Status alterado com sucesso!' }
  rescue ActiveRecord::RecordInvalid
    result(VERIFY.result({ object: @object, flag: true, status: :unprocessable_entity }))
  end
end
