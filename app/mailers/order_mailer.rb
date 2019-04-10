class OrderMailer < ApplicationMailer
  default from: 'bookstore@example.com'
  MESSAGE_THANKS_ORDER = 'Thanks for order'.freeze

  def send_thanks_for_order(order)
    @order = order
    @user = order.user
    mail(to: @user.email, body: MESSAGE_THANKS_ORDER)
  end
end
