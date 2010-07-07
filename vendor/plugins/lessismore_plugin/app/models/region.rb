class Region < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false
  has_many :locations
  default_scope :order => "name"
  has_permalink :name
  
  def to_param
    "#{self.id}-#{self.permalink}"
  end
end
