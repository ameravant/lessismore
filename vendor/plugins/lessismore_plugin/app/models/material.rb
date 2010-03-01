class Material < ActiveRecord::Base
  has_permalink :name
  has_and_belongs_to_many :articles
  has_and_belongs_to_many :related_materials, :class_name => "Material", :join_table => "related_materials", :foreign_key => "main_material_id", :association_foreign_key => "related_material_id"
  belongs_to :material_category
  has_and_belongs_to_many :events
  has_and_belongs_to_many :locations
  validates_presence_of :name, :material_category_id, :position
  validates_uniqueness_of :name, :case_sensitive => false
  validates_numericality_of :material_category_id
  default_scope :order => "name"
  has_attached_file :introduction_banner_image, :styles => { :intro => "320x230"}


  def to_param
    "#{self.id}-#{self.permalink}"
  end
  def material_category_name
    self.material_category.name
  end
end

