# venue_serializer.rb
class VenueSerializer < ActiveModel::Serializer
  attributes :name, :coordinates, :shows_count, :slug => :id

  # has_many :shows, serializer: ShowSerializer, include: true, embed: :ids, key: :shows

  def shows_count
    object.shows.upcoming.size
  end
end
