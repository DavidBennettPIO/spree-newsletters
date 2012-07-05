class NewsletterJob < Struct.new(:sids, :newsletter_id)

  def perform
    
    newsletter = Newsletter.find(newsletter_id)
    
    message = NewsletterMailer.send_newsletter(newsletter)
    
    if !sids.nil?
      recipients = NewsletterRecipient.where(:state_id => sids).all
    else
      recipients = NewsletterRecipient.where(:email => 'davidbennett@bravevision.com').all
    end
    
    recipients.each do |recipient|
      puts recipient.name
      mail = message.clone
      mail.to = "#{recipient.name} <#{recipient.email}>"
      mail.deliver

    end
    
  end
  
end
