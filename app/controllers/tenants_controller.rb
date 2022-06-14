class TenantsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  
  def index
    tenants = Tenant.all
    render json: tenants
  end

  def show
    tenant = find_tenant
    render json: tenant, status: :ok
  end

  def create
    tenant = Tenant.create!(tenant_params)
    render json: tenant, status: :created
  end

  def update
    tenant = find_tenant
    tenant.update!(tenant_params)
    render json: tenant, status: :accepted
  end

  def destroy
    tenant = find_tenant
    tenant.destroy
    head :no_content, status: :no_content
  end


  private

  def find_tenant
    Tenant.find(params[:id])
  end

  def record_invalid
    render json: {error: "Invalid entry"}, status: :unprocessable_entity
  end

  def record_not_found
    render json: {error: "Tenant not found"}, status: :not_found
  end

  def tenant_params
    params.permit(:name, :age)
  end

end
