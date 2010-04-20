class Location < ActiveRecord::Base
  #include Geokit::Geocoders

  has_permalink :name
  has_and_belongs_to_many :materials
  validates_presence_of :name
  validates_presence_of :address, :message => "must be filled-in with a real address"
  validates_presence_of :city, :state, :if => :zip_blank?, :message => "must be entered when zip is blank"
  validates_presence_of :zip, :if => :city_or_state_blank?, :message => "must be entered when city or state are blank"
  validates_numericality_of :zip, :message => "must be a 5 digit number", :allow_blank => true
  validates_length_of :zip, :is => 5, :message => "must be a 5 digit number", :allow_blank => true
  validates_numericality_of :lat, :lng, :allow_blank => true
  #before_validation :replace_with_geokit_address, :if => :record_changed?
  named_scope :by_name, :order => "name"
  default_scope :order => "state, city"
  belongs_to :region

  def to_param
    "#{self.id}-#{self.permalink}"
  end

  def region_name
    if self.region
      self.region.name
    elsif self.city
      self.city
    end
  end

  def zip_blank?
    self.zip.blank?
  end

  def city_or_state_blank?
    self.city.blank? or self.state.blank?
  end

  def city_state
    "#{self.city}, #{self.state}"
  end

  def city_state_zip
    "#{self.city_state} #{self.zip}"
  end

  def full_address_sans_zip
    "#{self.address} #{self.city_state}"
  end

  def full_address
    "#{self.full_address_sans_zip} #{self.zip}"
  end

  def lng_lat
    "#{self.lng},#{self.lat}"
  end


  private

  # def record_changed?
  #    self.changed?
  #  end
  # 
  #  def replace_with_geokit_address
  #     # Uses Geokit plugin to get full address and coordinates for the newly added
  #     # location. Replacees all given data with geokit's data.
  #     geo = MultiGeocoder.geocode(self.full_address)
  #     self.attributes = {
  #       :address          => geo.street_address,
  #       :city             => geo.city,
  #       :state            => geo.state,
  #       :zip              => geo.zip,
  #       :lat              => geo.lat,
  #       :lng              => geo.lng,
  #       :geokit_provider  => geo.provider,
  #       :geokit_precision => geo.precision,
  #       :geokit_accuracy  => geo.accuracy,
  #       :geokit_success   => true
  #     } if geo.success
  #   end
 
end

