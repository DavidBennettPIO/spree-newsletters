class CreateNewsletterCopies < ActiveRecord::Migration
  def change
    create_table :newsletter_copies do |t|
      t.references :newsletter
      t.string :title
      t.text :body
      
      t.boolean :show_title
      t.boolean :small_text
      
    end
    add_index :newsletter_copies, :newsletter_id
  end
end
