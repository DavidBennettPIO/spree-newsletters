module Spree
  class NewsletterCopy < ActiveRecord::Base
    belongs_to :newsletter
  end
end
