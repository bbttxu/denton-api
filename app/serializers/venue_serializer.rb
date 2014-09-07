# venue_serializer.rb
class VenueSerializer < ActiveModel::Serializer
  attributes :name, :coordinates, :id, :slug, :shows_count

  has_many :shows, serializer: ShowSerializer, include: true, embed: :ids, key: :shows

  def shows_count
    object.shows.upcoming.size
  end
end
