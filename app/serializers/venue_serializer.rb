# venue_serializer.rb
class VenueSerializer < ActiveModel::Serializer
  attributes :name, :coordinates, :shows_count, :slug => :id

  has_many :shows, include: false

  def shows_count
    object.shows.size
  end
end
