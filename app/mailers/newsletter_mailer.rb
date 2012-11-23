class NewsletterMailer < ActionMailer::Base
  layout 'newsletter'
  helper :newsletter
  helper 'spree/base'
  helper :products
  default :from => "noreply@triggahappi.com.au"
  
  
  def send_newsletter(newsletter)
    @newsletter = newsletter
    
    @in_mailer = true
    
    attachments.inline['triggahappi_logo_34.jpg'] = File.read('/var/www/triggahappi/public/asets/triggahappi_logo_34.jpg')
    
    @newsletter.newsletter_lines.where(:module_name => 'image').each do |newsletter_line|
      image = NewsletterImage.find(newsletter_line.module_id)
      attachments.inline[image.newsletter_image.path(:normal).split('/').last] = File.read(image.newsletter_image.path(:normal))
    end    
    
    mail(
      :subject => @newsletter.subject
      )
    
  end
end