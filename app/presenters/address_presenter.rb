class AddressPresenter < Rectify::Presenter
  attribute :params
  attribute :current_user, User

  def add_class_error(type, form)
    'has-error' unless form.errors[type].empty?
  end

  def exists_user_address(type)
    Address.find_by(resource_id: current_user.id, resource_type: 'User', address_type: type)
  end

  def current_value(value, type)
    current_address = exists_user_address(type)
    return current_address[value] if current_address

    params["#{type}_form"][value] if params && params["#{type}_form"]
  end

  def current_country(type)
    countries = ISO3166::Country.all
    current_address = exists_user_address(type)
    current_address ? countries.unshift(current_address.country) : countries
  end
end
