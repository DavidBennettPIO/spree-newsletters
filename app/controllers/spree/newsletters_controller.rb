module Spree
  class NewslettersController < ApplicationController

    helper :newsletter

    def show
      @newsletter = Spree::Newsletter.find(params[:id])
      Spree::User.where(:subscribed => true, :id => 1).each do |user|
        #NewsletterMailer.send_newsletter(user, @newsletter).deliver
      end
      render 'newsletter_mailer/send_newsletter', :layout => 'newsletter'
    end

  end
end
