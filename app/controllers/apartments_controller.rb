class ApartmentsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  
  def index
    apartments = Apartment.all
    render json: apartments
  end

  def show
    apartment = find_apartment
    render json: apartment, status: :ok
  end

  def create
    apartment = Apartment.create!(apartment_params)
    render json: apartment, status: :created
  end

  def update
    apartment = find_apartment
    apartment.update!(apartment_params)
    render json: apartment, status: :accepted
  end

  def destroy
    apartment = find_apartment
    apartment.destroy
    head :no_content, status: :no_content
  end


  private

  def find_apartment
    Apartment.find(params[:id])
  end

  def record_invalid
    render json: {error: "Invalid entry"}, status: :unprocessable_entity
  end

  def record_not_found
    render json: {error: "Apartment not found"}, status: :not_found
  end

  def apartment_params
    params.permit(:number)
  end
end
