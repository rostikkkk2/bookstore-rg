class AddressBaseService
  attr_reader :params, :current_user, :current_order, :billing, :shipping

  def initialize(params, current_user, current_order)
    @params = params
    @current_user = current_user
    @current_order = current_order
    @billing = AddressForm.new(params[:billing_form]&.permit!)
    @shipping = AddressForm.new(params[:shipping_form]&.permit!)
  end
end
