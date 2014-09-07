# venue_serializer.rb
class VenueSerializer < ActiveModel::Serializer
  attributes :name, :coordinates, :id

  # has_many :shows, serializer: ShowSerializer, include: true, embed: :ids, key: :shows

  # def shows_count
  #   object.shows.upcoming.size
  # end
end
