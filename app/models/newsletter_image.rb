class NewsletterImage < ActiveRecord::Base
  has_attached_file :newsletter_image,
  :styles => {
    :small => {:geometry => '120x600>', :quality => "91", :format => 'jpg'},
    :normal => {:geometry => '768x1000>', :quality => "80", :format => 'jpg'}
  },
  :convert_options => {
    :small => "-alpha off -fill black -opaque black -alpha on -background black -flatten",
    :normal => "-alpha off -fill black -opaque black -alpha on -background black -flatten"
  },
  :processors => [:thumbnail, :minimise]
end
