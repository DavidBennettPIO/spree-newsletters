module Spree
  class NewsletterRecipient < ActiveRecord::Base
    belongs_to :country
    belongs_to :state
  end
end
