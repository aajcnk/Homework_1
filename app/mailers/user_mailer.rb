class UserMailer < ApplicationMailer
  default from: "info@petitionrails.localhost"

  def petition_to_review(petition)
    @petition = petition
    @user = petition.user
    mail to: @user.email, subject: "Ваша петиция #{petition.title} будет расмотрена"
  end

  def petition_non_to_review(petition)
    @petition = petition
    @user = petition.user
    mail to: @user.email, subject: "Ваша петиция #{petition.title} не будет расмотрена"
  end
end
