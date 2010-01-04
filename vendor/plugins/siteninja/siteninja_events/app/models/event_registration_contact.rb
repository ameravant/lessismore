class EventRegistrationContact < ActiveRecord::Base
  belongs_to :event_registration
  belongs_to :contact
  belongs_to :event_price
  has_one :event, :through => :event_registration
  
  def paid?
    self.registration.paid
  end
  
  def payment_type
    r = self.registration
    if r.card?
      "(Credit Card)"
    elsif r.cash?
      "(Cash)"
    elsif r.check?
      "(Check)"
    end
  end
  
end
