class SerializableSeason < JSONAPI::Serializable::Resource
  type 'seasons'

  attributes :title, :plot

  has_many :episodes do
    data do
      @object.episodes
    end

    link :related do
      @url_helpers.api_v1_season_episodes_url(@object.id)
    end

    meta do
      { count: @object.episodes.count }
    end

    link :self do
      @url_helpers.api_v1_season_url(@object.id)
    end

    meta do
      { featured: true }
    end
  end

end
