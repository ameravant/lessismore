class Contact < ActiveRecord::Base
  belongs_to :contactable, :polymorphic => true, :counter_cache => true
  has_and_belongs_to_many :contact_groups
  validates_presence_of :first_name, :last_name, :email
  validates_format_of :email, :with => /(^([^@\s]+)@((?:[-_a-z0-9]+\.)+[a-z]{2,})$)|(^$)/i, :allow_blank => true

  def name
    "#{self.first_name} #{self.last_name}"
  end

  def name_reversed
    "#{self.last_name}, #{self.first_name}"
  end
end
