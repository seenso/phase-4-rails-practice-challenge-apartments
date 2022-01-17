class TenantsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    render json: Tenant.all
  end

  def show 
    tenant = find_tenant
    render json: tenant
  end

  def create 
    tenant = Tenant.create!(tenant_params)
    render json: tenant, status: :created
  end

  def update 
    tenant = Tenant.find(params[:id])
    tenant.update!(tenant_params)
    render json: tenant, status: :accepted
  end

  def destroy 
    tenant = find_tenant
    tenant.destroy
    head :no_content
  end

  private

  def find_tenant
    Tenant.find(params[:id])
  end

  def tenant_params
    params.permit(:id, :name, :age)
  end

  def render_unprocessable_entity_response(invalid)
    render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
  end

  def render_not_found_response
    render json: {error: "Record not found"}, status: :not_found
  end
end
