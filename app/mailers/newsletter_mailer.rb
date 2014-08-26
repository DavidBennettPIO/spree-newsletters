class NewsletterMailer < ActionMailer::Base

  layout 'newsletter'

  helper :application
  helper :newsletter
  helper 'spree/base'
  helper 'spree/products'

  default :from => "noreply@triggahappi.com.au"
  
  
  def send_newsletter(newsletter)
    @newsletter = newsletter
    
    @in_mailer = true
    
    attachments.inline['triggahappi_logo_30.jpg'] = File.read(SpreeNewsletters::Engine.root.join('app/assets/images/triggahappi_logo_30.jpg'))
    
    @newsletter.newsletter_lines.where(:module_name => 'image').each do |newsletter_line|
      image = Spree::NewsletterImage.find(newsletter_line.module_id)
      attachments.inline[image.newsletter_image.path(:normal).split('/').last] = File.read(image.newsletter_image.path(:normal))
    end    
    
    mail(
      :subject => @newsletter.subject
      )
    
  end
end