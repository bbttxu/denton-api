module BSON
  class ObjectId
    alias :to_json :to_s
    alias :as_json :to_s
  end
end

class ShowSerializer < ActiveModel::Serializer
  attributes :id, :starts_at, :source, :time_is_uncertain, :price

  has_many :gigs, serializer: GigSerializer, embed: :ids, include: true, key: :gigs
  has_one :venue, serializer: VenueSerializer, embed: :ids, include: true, key: :venues
end
