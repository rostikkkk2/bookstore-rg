class AddressPresenter < Rectify::Presenter
  attribute :params
  attribute :current_user, User
  attribute :current_order
  attribute :billing_form
  attribute :shipping_form
  CLASS_HAS_ERROR = 'has-error'.freeze
  TYPE_USER_IN_ADDRESS = 'User'.freeze
  TYPE_ORDER_IN_ADDRESS = 'Order'.freeze

  def step
    'address'
  end

  def billing
    billing_form || AddressForm.new
  end

  def shipping
    shipping_form || AddressForm.new
  end

  def add_class_error(type, form)
    CLASS_HAS_ERROR unless form.errors[type].empty?
  end

  def exists_address(resource_id, type_address, type_form)
    Address.find_by(resource_id: resource_id, resource_type: type_address, address_type: type_form)
  end

  def current_value(value, type, current_form)
    current_address = check_current_address(type)
    return current_address[value] if current_address

    current_form.attributes[value]
  end

  def check_current_address(type)
    return exists_address(current_user.id, TYPE_USER_IN_ADDRESS, type) if current_user

    exists_address(current_order.id, TYPE_ORDER_IN_ADDRESS, type) || exists_address(current_order.user.id, TYPE_USER_IN_ADDRESS, type) if current_order
  end

  def current_country(type)
    countries = ISO3166::Country.all
    current_address = check_current_address(type)
    current_address ? countries.unshift(current_address.country) : countries
  end
end
