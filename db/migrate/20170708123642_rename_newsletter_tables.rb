class RenameNewsletterTables < ActiveRecord::Migration
  def self.up
    rename_table :newsletters,              :spree_newsletters
    rename_table :newsletter_lines,         :spree_newsletter_lines
    rename_table :newsletter_copies,        :spree_newsletter_copies
    rename_table :newsletter_images,        :spree_newsletter_images
    rename_table :newsletter_recipients,    :spree_newsletter_recipients
  end

  def self.down
    rename_table :spree_newsletters,              :newsletters
    rename_table :spree_newsletter_lines,         :newsletter_lines
    rename_table :spree_newsletter_copies,        :newsletter_copies
    rename_table :spree_newsletter_images,        :newsletter_images
    rename_table :spree_newsletter_recipients,    :newsletter_recipients
  end
end
