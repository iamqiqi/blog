class UserMailer < ApplicationMailer
  default from: 'WeiboSucks<iamqiqijiang@gmail.com>'

  def follower_notification_email(username, follower)
    @user = User.find_by_username(username)
    @follower = follower
    mail(to: @user.email, subject: 'weibosucks notification')
  end

  def article_notification_email(username, author, article)
    @fan = User.find_by_username(username)
    @author = author
    @article = article
    mail(to: @fan.email, subject: 'weibosucks notification')
  end
end
