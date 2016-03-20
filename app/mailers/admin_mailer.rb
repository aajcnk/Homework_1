class AdminMailer < ApplicationMailer
  default from: "info@petitionrails.localhost"

  def petition_to_review(petition)
    @petition = petition
    @user = petition.user
    mail to: @admin.email, subject: "Петиция #{petition.title} к расмотрению"
  end

end
