class Public::ContactMailer < ApplicationMailer
# rails g mailer ContactMailer

  def send_mail(contact)
    @contact = contact
    mail to: ENV['TOMAIL'], subject: '[お問い合わせ]' + @contact.subject.to_s
  end



end
