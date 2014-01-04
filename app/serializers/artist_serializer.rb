module BSON
  class ObjectId
    alias :to_json :to_s
    alias :as_json :to_s
  end
end

class ArtistSerializer < ActiveModel::Serializer
  attributes :id, :name

end
