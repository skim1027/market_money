class Api::V0::VendorsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_bad_request_response

  def show
    render json: VendorSerializer.new(Vendor.find(params[:id]))
  end

  def create
    vendor = Vendor.new(vendor_params)
    if vendor.save
      render json: VendorSerializer.new(vendor), status: :created
    else
      render_bad_request_response(vendor)
    end
  end

  def update
    vendor = Vendor.find(params[:id])
    if vendor.update(update_vendor_params)
      render json: VendorSerializer.new(vendor)
    else
      render_bad_request_response(vendor)
    end
  end

  def destroy
    render json: Vendor.destroy(params[:id])
    head :no_content
  end

  private

  def vendor_params
    params.require(:vendor).permit(:name, :description, :contact_name, :contact_phone, :credit_accepted)
  end

  def update_vendor_params
    params.fetch(:vendor, {}).permit!
  end

  def render_bad_request_response(exception)
    render json: ErrorSerializer.new(ValidationErrorMessage.new(exception.errors.full_messages.join(', '), 400)).serialize_json, status: :bad_request
  end
end