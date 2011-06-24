class NewslettersController < ApplicationController
  helper :newsletter
  def show
    @newsletter = Newsletter.find(params[:id])
    User.where(:subscribed => true, :id => 1).each do |user|
      #NewsletterMailer.send_newsletter(user, @newsletter).deliver
    end
    render 'newsletter_mailer/send_newsletter', :layout => 'newsletter'
  end
end
