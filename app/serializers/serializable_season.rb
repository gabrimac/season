class SerializableSeason < JSONAPI::Serializable::Resource
  type 'seasons'

  attributes :title, :plot

  has_many :episodes do
    data do
      @object.episodes_number_order
    end

    meta do
      { count: @object.episodes.count }
    end

    meta do
      { featured: true }
    end
  end

end
