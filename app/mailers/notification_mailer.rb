class NotificationMailer < ApplicationMailer
  default from: 'ケアハウス<fukuta.yudai@gmail.com>'

  def notice_care_home_post_mail(user)
    @user = user
    mail(
      subject: "#{user.name}様の写真が投稿されました・",
      to: @user.email
    ) do |format|
      format.text
    end
  end
end
