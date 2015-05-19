class UserMailer < ApplicationMailer
  default from: Settings.default_mail

  def notice_exam user
    mail to: user.email, subject: I18n.t("email.notice_exam")
  end
end
