class Event < ActiveRecord::Base
  has_permalink :name
  belongs_to :user, :counter_cache => true
  has_many :event_prices, :dependent => :destroy
  has_many :event_registrations # registrations.event_id
  has_many :contacts, :through => :event_registrations # registrations.contact_id
  validates_presence_of :name, :date_and_time
  validates_numericality_of :registration_limit, :allow_blank => true
  validates_presence_of :registration_closed_text, :if => :registration_limit?
  validates_presence_of :registration, :if => :allow_check_or_cash?, :message => "must be required if you accept cash or check payment"
  validates_presence_of :check_instructions, :if => :allow_check?, :message => "must be provided to the registrant"
  named_scope :future, lambda { { :conditions => ["date_and_time >= ?", Date.today.to_time] }, :order => "date_and_time" } 
  named_scope :this_week, lambda { { :conditions => { :date_and_time => (Date.today.to_time..(Date.today + 6).to_time) } } }
  named_scope :this_month, lambda { { :conditions => { :date_and_time => (Date.today.to_time..(Date.today + 29).to_time)  } } }
  named_scope :three_months, lambda { { :conditions => { :date_and_time => (Date.today.to_time..(Date.civil(Date.today.year, Date.today.month, 1) >> 3).to_time)  } } }
  named_scope :this_year, lambda { { :conditions => { :date_and_time => (Date.today.to_time..Date.today.next_year.to_time)  } } }
  named_scope :past, lambda { { :conditions => ["date_and_time < ?", Date.today.to_time] } }
  named_scope :soonest, :limit => 6
  default_scope :order => "date_and_time"
  
  def to_param
    "#{self.id}-#{self.permalink}"
  end

  def registration_count
    # A person is considered registered if:
    #   (a) the registration record they are associated with is approved; or
    #   (b) their registration contact record was created in the last 30 minutes
    EventRegistrationContact.find(:all, :include => :event_registration, :conditions => [
        "event_id = ? and ((event_registrations.approved = ?) or (event_registrations.approved = ? and contact.created_at >= ?))",
        self.id, true, false, 30.minutes.ago]
      ).flatten.compact.uniq.size
  end

  def spots_available
    self.registration_limit - self.registration_count
  end
  
  def registration_spots?
    self.registration_limit ? (self.registration_count < self.registration_limit) : true
  end
  
  def registration_limit?
    self.registration_limit
  end
  
  def allow_check_or_cash?
    self.allow_check? or self.allow_cash?
  end
  
  def future?
    self.date_and_time >= Date.today.to_time
  end
  
  def today?
    self.date_and_time < Date.tomorrow.to_time
  end
  
  def tomorrow?
    self.date_and_time < (Date.today + 1.day).to_time
  end
  
  def this_week?
    self.date_and_time.to_date.cweek == Date.today.cweek
  end
  
end
