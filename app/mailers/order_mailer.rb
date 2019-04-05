class OrderMailer < ApplicationMailer
  default from: 'bookstore@example.com'

  def send_thanks_for_order(order)
    @order = order
    @user = order.user
    mail(to: @user.email, body: 'thanks for order')
  end
end
