class Newsletter < ActiveRecord::Base
  has_many :newsletter_lines
end
