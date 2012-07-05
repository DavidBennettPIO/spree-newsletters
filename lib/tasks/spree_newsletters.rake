# add custom rake tasks here
namespace :newsletters do
  
  desc "Copy Newsletter Recipients from Users"
  task :copy_users => :environment do
    User.registered.all.each do |u|
      o = Order.complete.where(:user_id => u.id).first
      unless o.nil?
        a = o.bill_address
        unless a.state_id.nil?
          nr = NewsletterRecipient.new()
          nr.name = a.firstname + " " + a.lastname
          nr.email = u.email
          nr.country_id = a.country_id
          nr.state_id = a.state_id
          nr.save
        end
        puts a.country_id
        puts a.state_id
      end
    end
  end
end