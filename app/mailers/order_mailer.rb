class OrderMailer < ApplicationMailer
  default from: 'no-reply@marketplace-api.com'

  def send_confirmation(order)
    @order = order
    @user = @order.user
    mail to: @user.email, subject: 'Order Confirmation'
  end
end
