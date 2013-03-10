class UserMailer < ActionMailer::Base
  default from: "dontworryapp@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.beta_signup_confirmation.subject
  #
  def beta_signup_confirmation(user)
    @user = user

    mail to: @user.email, subject: "Thanks from Don't Worry!"
  end
end
