class SerializableMovie < JSONAPI::Serializable::Resource
  type 'movies'

  attributes :title, :plot
end
