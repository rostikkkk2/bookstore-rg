class AddressPresenter < Rectify::Presenter
  attribute :params
  attribute :current_user, User
  attribute :current_order
  attribute :show_order
  attribute :billing
  attribute :shipping
  attribute :step

  def add_class_error(type, form)
    'has-error' unless form.errors[type].empty?
  end

  def exists_address(resource_id, type_address, type_form)
    Address.find_by(resource_id: resource_id, resource_type: type_address, address_type: type_form)
  end

  def current_value(value, type)
    current_address = check_current_address(type)
    return current_address[value] if current_address

    params["#{type}_form"][value] if params && params["#{type}_form"]
  end

  def check_current_address(type)
    return exists_address(current_order.id, 'Order', type) || exists_address(current_order.user.id, 'User', type) if show_order

    exists_address(current_user.id || current_order.user.id, 'User', type)
  end

  def current_country(type)
    countries = ISO3166::Country.all
    current_address = check_current_address(type)
    current_address ? countries.unshift(current_address.country) : countries
  end
end
