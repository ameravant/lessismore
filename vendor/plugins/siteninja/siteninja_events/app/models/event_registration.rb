class EventRegistration < ActiveRecord::Base
  belongs_to :event
  belongs_to :contact
  has_many :event_transactions # transactions.registration_id
  has_many :contacts
  has_many :contacts, :through => :registration_contacts
  
  def payment_method
    if self.card?
      "PayPal"
    elsif self.cash?
      "Cash"
    elsif self.check?
      "Check"
    end
  end
  
  def calculate_total
    rc = RegistrationContact.find(:all, :conditions => { :registration_id => self.id }, :include => :event_price)
    total = 0.0
    for x in rc
      total += x.event_price.price
    end
    total
  end
  
  def send_notification_emails
    event = Event.find(self.event_id)
    rcs = RegistrationContact.find_all_by_registration_id(self.id, :include => :contact, :order => "contacts.last_name, contacts.first_name")
    total = self.calculate_total

    for rc in rcs
      c = rc.contact
      if rc.owner? and !c.email.blank?
        # Registration owner
        PostOffice.deliver_event_registration_owner(c, event, self, total, rcs)
      elsif !c.email.blank?
        # Guest with present email address
        registration_owner ||= RegistrationContact.find_by_registration_id_and_owner(self.id, true, :include => :contact)
        PostOffice.deliver_event_registration_guest(c.name, c.email, event.permalink, event.title, event.date_and_time, registration_owner.contact.name)
      end
    end
  end

end
