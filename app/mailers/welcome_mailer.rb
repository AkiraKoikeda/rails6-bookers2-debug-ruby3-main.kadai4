class WelcomeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.welcome_mailer.send_up_signup.subject
  #
  def send_up_signup
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
