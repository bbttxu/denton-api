# venue_serializer.rb
class VenueSerializer < ActiveModel::Serializer
  attributes :id, :name, :coordinates, :slug

end
