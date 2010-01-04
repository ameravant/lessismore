class Image < ActiveRecord::Base
  belongs_to :viewable, :polymorphic => true, :counter_cache => true
  has_attached_file :image, :styles => { :thumb => "48x36#", :small => "85x55#", :medium => "200x142#", :large => "880x9999>", :slide => "550x9999>" }
  validates_attachment_presence :image
  acts_as_taggable
end
