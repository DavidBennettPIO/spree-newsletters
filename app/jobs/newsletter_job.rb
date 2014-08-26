class NewsletterJob < Struct.new(:sids, :newsletter_id)

  def perform
    
    newsletter = Spree::Newsletter.find(newsletter_id)
    
    message = Spree::NewsletterMailer.send_newsletter(newsletter)
    
    if !sids.nil?
      recipients = Spree::NewsletterRecipient.where(:state_id => sids).all
    else
      recipients = Spree::NewsletterRecipient.where(:email => ['davidbennett@bravevision.com','admin@triggahappi.com.au']).all
    end
    
    recipients.each do |recipient|
      puts recipient.name
      mail = message.clone
      mail.to = "#{recipient.name} <#{recipient.email}>"
      mail.deliver

    end
    
  end
  
end
