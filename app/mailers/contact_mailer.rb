class ContactMailer < ApplicationMailer
  def contact_mail(contact)
    @contact = contact
    mail to:"test123123@gmail.com",subject: "confirmation"
  end
end
