class CreateNewsletterLines < ActiveRecord::Migration
  def self.up
    create_table :newsletter_lines do |t|
      t.references :newsletter
      t.string :module_name
      t.integer :module_id
      t.string :module_value
      t.string :permalink
      
      t.integer :email_sent
      t.integer :email_view
      t.integer :email_click
      
      t.integer :position

      t.timestamps
    end
  end

  def self.down
    drop_table :newsletter_lines
  end
end
