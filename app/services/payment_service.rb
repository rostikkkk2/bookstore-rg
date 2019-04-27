class PaymentService
  attr_reader :params, :current_order, :current_user, :form

  def initialize(params, current_user, current_order)
    @params = params
    @current_order = current_order
    @current_user = current_user
    @form = CreditCardForm.new(credit_card_params)
  end

  def call
    create_or_update_card if form.valid?
  end

  def create_or_update_card
    current_order.credit_card ? update_credit_card : create_credit_card
  end

  def create_credit_card
    CreditCard.new(form.attributes).save
  end

  def update_credit_card
    current_order.credit_card.update(form.attributes.without(:order_id))
  end

  def credit_card_params
    params[:credit_card_form]&.permit!
  end
end
