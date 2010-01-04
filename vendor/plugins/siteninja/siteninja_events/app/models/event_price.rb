class EventPrice < ActiveRecord::Base
  belongs_to :event
  validates_presence_of :description, :price
  validates_numericality_of :price, :allow_blank => true
end
