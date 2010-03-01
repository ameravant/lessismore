class MaterialCategory < ActiveRecord::Base
  has_permalink :name
  has_many :materials
  has_and_belongs_to_many :articles
  has_and_belongs_to_many :events
  validates_presence_of :name, :short_name
  validates_uniqueness_of :name, :case_sensitive => false
  default_scope :order => "name"
  has_attached_file :introduction_banner_image, :styles => { :intro => "320x230"}

  
  def to_param
    "#{self.id}-#{self.permalink}"
  end
end
