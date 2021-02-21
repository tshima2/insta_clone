class FeedsMailer < ApplicationMailer
  def feeds_mail(feed)
    @feed = feed
    mail to: "shima.tatsurou@gmail.com", subject: "画像投稿のお知らせメール"
  end
end
