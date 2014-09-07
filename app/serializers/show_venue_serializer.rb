# show_venue_serializer.rb
class ShowVenueSerializer < ActiveModel::Serializer
  attributes :name, :coordinates, :id
end
