# A venue is a location
class Venue
  include Mongoid::Document
  include Mongoid::Timestamps
  include Geocoder::Model::Mongoid

  field :name, :type => String
  field :phone, :type => String
  field :address, :type => String
  field :coordinates, :type => Array

  validates_presence_of :name, :phone, :address
  validates_uniqueness_of :name, :phone, :address

  has_many :shows
  
  after_validation :geocode       
  geocoded_by :address
end
