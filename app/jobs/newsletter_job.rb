class NewsletterJob < Struct.new(:sids, :newsletter_id)

  def perform
    
    newsletter = Spree::Newsletter.find(newsletter_id)
    
    message = NewsletterMailer.send_newsletter(newsletter)
    
    if !sids.nil?
      recipients = Spree::NewsletterRecipient.where(:state_id => sids).all
    else

      emails = []
      Spree::Role.where(name: 'admin').first.users.each do |user|
        admin_recip = Spree::NewsletterRecipient.where( email: user.email )
        if admin_recip.nil?
          c ||= Spree::Country.first
          s ||= Spree::State.first
          Spree::NewsletterRecipient.create( name: 'Admin Test', email: user.email, country: c, state: s )
        end
        emails << user.email
      end
      recipients = Spree::NewsletterRecipient.where(email: emails).all
    end
    
    recipients.each do |recipient|
      puts recipient.name
      mail = message.clone
      mail.to = "#{recipient.name} <#{recipient.email}>"
      mail.deliver

    end
    
  end
  
end
