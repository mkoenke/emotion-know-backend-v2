class ChildMailer < ApplicationMailer

  def password_reset_for_child(parent)
    @parent = parent
    mail to: parent.email, subject: "Password Reset for Your Child"
end
  
end
