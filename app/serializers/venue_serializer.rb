# venue_serializer.rb
class VenueSerializer < ActiveModel::Serializer
  attributes :name, :coordinates, :id, :slug, :shows_count, :next_show

  has_many :shows, serializer: ShowSerializer, include: true, embed: :ids, key: :shows

  def shows_count
    object.shows.upcoming.size
  end

  def next_show
    foo = object.shows.upcoming.first || nil
    return foo['starts_at'] if foo
    foo
  end
end
