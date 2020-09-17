class ContactMailer < ApplicationMailer
  def contact_mail(post)
    @post = post
    mail to: @post.user.email,  subject: "Inquiry email confirmation"
  end
end
