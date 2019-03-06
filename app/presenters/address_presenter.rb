class AddressPresenter < Rectify::Presenter
  attribute :errors
  attribute :params
  attribute :current_user, User

  def add_class_error(type, form)
    'has-error' if exists_error?(type) && params[form]
  end

  def show_errors(type, form)
    errors[type].join(', ').capitalize if exists_error?(type) && params[form]
  end

  def exists_error?(type)
    errors && !errors[type].empty?
  end

  def exists_user_address(type)
    Address.find_by(resource_id: current_user.id, resource_type: 'User', address_type: type)
  end

  def current_value(value, type)
    current_address = exists_user_address(type)
    return current_address[value] if current_address

    params[type][value] if params && params[type]
  end
end
