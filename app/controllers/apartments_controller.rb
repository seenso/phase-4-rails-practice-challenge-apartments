class ApartmentsController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  # GET /apartments
  def index 
    render json: Apartment.all
  end

  # GET /apartments/:id
  def show
    apartment = find_apt
    render json: apartment
  end

  # POST /apartments
  def create 
    apartment = Apartment.create!(apartment_params)
    render json: apartment, status: :created
  end

  # GET /apartments/:id
  def update
    apartment = find_apt
    apartment.update!(apartment_params)
    render json: apartment, status: :accepted
  end

  # DELETE /apartments/:id
  def destroy
    apartment = find_apt
    apartment.destroy
    head :no_content
  end

  private

  def find_apt
    Apartment.find(params[:id])
  end

  def apartment_params
    params.permit(:number)
  end

  def render_unprocessable_entity_response
    render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
  end

  def render_not_found_response
    render json: {error: "Apartment not found"}, status: :not_found
  end

end
