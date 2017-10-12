class UserMailer < ApplicationMailer
  default from: 'no-reply@jungle.com'
  
   def email_receipt(order)
    @email = order.email
    @order_total = order.total
    @line_items = order.line_items

     mail(to: @email, subject: "Order # #{order.id}")
   end
end
