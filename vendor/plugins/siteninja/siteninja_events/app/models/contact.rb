class Contact < ActiveRecord::Base
  validates_presence_of :first_name, :last_name, :email
  validates_format_of :email, :with => /(^([^@\s]+)@((?:[-_a-z0-9]+\.)+[a-z]{2,})$)|(^$)/i, :allow_blank => true

  def name
    "#{self.first_name} #{self.last_name}"
  end

  def name_reversed
    "#{self.last_name}, #{self.first_name}"
  end
end
