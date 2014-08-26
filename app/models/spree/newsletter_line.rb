module Spree
  class NewsletterLine < ActiveRecord::Base
    belongs_to :newsletter
    acts_as_list :scope => :newsletter
    default_scope :order => 'position'
  end
end
