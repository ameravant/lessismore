class Setting < ActiveRecord::Base
  validates_presence_of :footer_text, :inquiry_notification_email
  has_attached_file :logo, :styles => { :thumb => "48x36#", :small => "85x55#", :medium => "9999>x93", :large => "880x9999>", :slide => "550x9999>" }
  has_attached_file :introduction_banner_image, :styles => { :thumb => "48x36#", :small => "85x55#", :medium => "9999>x93", :large => "880x9999>", :slide => "550x9999>" }

end
