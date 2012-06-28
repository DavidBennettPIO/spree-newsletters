class CreateNewsletterRecipients < ActiveRecord::Migration
  def self.up
    create_table :newsletter_recipients do |t|
      t.references :country
      t.references :state
      t.string :name
      t.string :email
      t.timestamps
    end
    add_index(:newsletter_recipients, :email)
    add_index(:newsletter_recipients, :country_id)
    add_index(:newsletter_recipients, :state_id)
  end

  def self.down
    drop_table :pages
  end
end
