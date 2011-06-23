class NewslettersController < ApplicationController
  def show
    
    @newsletter = Newsletter.find(params[:id])
    user = User.find(params[:id])
    NewsletterMailer.send_newsletter(user, @newsletter).deliver
    render 'newsletter_mailer/send_newsletter', :layout => 'newsletter'
  end
end
