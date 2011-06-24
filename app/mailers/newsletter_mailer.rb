class NewsletterMailer < ActionMailer::Base
  layout 'newsletter'
  helper :newsletter
  helper 'spree/base'
  helper :products
  default :from => "noreply@triggahappi.com.au"
  
  
  def send_newsletter(user, newsletter)
    @newsletter = newsletter
    mail(
      :to => user.email,
      :subject => "Please see the Terms and Conditions attached"
      )
    
  end
end