class AddSubscriptionToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    
    add_column :users, :locale, :string, :null => false, :default => 'en-AU'
    
    add_column :users, :state, :string
    add_column :users, :postcode, :integer, :length => 4
    
    add_column :users, :subscribed, :boolean
    
    add_column :users, :email_errors, :integer, :length => 2, :null => false, :default => 0
    add_column :users, :email_sent, :integer, :null => false, :default => 0
    add_column :users, :email_views, :integer, :null => false, :default => 0
    add_column :users, :email_clicks, :integer, :null => false, :default => 0
  end

  def self.down
  end
end
