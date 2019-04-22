class CartUpdateService
  ONE_ITEM = 1
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    line_item = find_current_item
    new_quantity = change_quantity_item(line_item)
    update_column(new_quantity, line_item)
  end

  def find_current_item
    LineItem.find_by(id: params[:id].to_i)
  end

  def change_quantity_item(line_item)
    params[:plus] ? line_item.quantity += ONE_ITEM : line_item.quantity -= ONE_ITEM
  end

  def update_column(new_quantity, line_item)
    line_item.update_column(:quantity, new_quantity) if new_quantity.positive?
  end
end
