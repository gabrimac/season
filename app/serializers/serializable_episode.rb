class SerializableEpisode < JSONAPI::Serializable::Resource
  type 'episodes'

  attributes :title, :plot
end
