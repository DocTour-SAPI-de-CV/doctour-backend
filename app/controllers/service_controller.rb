# frozen_string_literal: true

# rubocop:disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity, Lint/MissingCopEnableDirective, Metrics/AbcSize
class ServiceController < ApplicationController
  include ErrorSerializer

  rescue_from ActionController::ParameterMissing, with: :missing_params

  def show
    # @services = Service.new(nil).find
    @services = Service.all
  end

  def index
    @service = Service.find(params[:id])
  end

  def create
    name = params[:name]
    price = params[:price]
    description = params[:description]
    if !name.nil? && !price.nil?
      check_create_fields(name, price, description)
    else
      render(json: { Erro: 'É obrigatório name e price' },
             status: :unprocessable_entity)
    end
  end

  def delete
    @service = Service.find(params[:id])
    @service.destroy!
    render(json: { "service_id deleted": params[:id] })
  end

  def update
    description = params[:description]
    if params[:name].nil? && params[:price].nil? && description.nil?
      without_fields_error
    else
      service = Service.find_by(id: params[:id])
      update_name(service, params[:name]) unless params[:name].nil?
      update_price(service, params[:price]) unless params[:price].nil?
      update_description(service, description) unless description.nil?
      render(json: { "service_id updated": params[:id] })
    end
  end

  private

  def check_create_fields(name, price, description)
    service = Service.find_by(
      name: name
    )
    if service.nil?
      create_service(name, price, description)
    else
      render(json: { Erro: 'Já existe um serviço com esse nome' },
             status: :unprocessable_entity)
    end
  end

  def create_service(name, price, description)
    service = Service.create(
      name: name,
      price: price,
      description: description
    )
    service.save!
    render(json: { "service_id created": service.id })
  end

  def without_fields_error
    render(json: { Erro: 'É necessário passar pelo menos um dos
            campos: name, price ou description' },
           status: :unprocessable_entity)
  end

  def update_name(service, name)
    check = Service.find_by(name: name)
    if check.nil?
      service.update(name: name)
      service.save!
    else
      render(json: { Erro: 'Já existe um serviço com esse nome' },
             status: :unprocessable_entity)
    end
  end

  def update_price(service, price)
    return unless price.class == Integer || price.class == Float

    service.update(price: price)
    service.save!
  end

  def update_description(service, description)
    return unless description.class == String

    service.update(description: description)
    service.save!
  end
end
