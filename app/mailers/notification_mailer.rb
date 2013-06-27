# encoding: UTF-8

class NotificationMailer < ActionMailer::Base
  default from: "support@tocarta.es"

  def invalid_passwords(user)
    @user = user
    mail(to: @user.email, cc: ENV['EMAIL_ADMIN'] , subject: "Contraseña errónea")
  end
end
