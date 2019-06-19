class Season < Content
  has_many :episodes

  def self.cache_key(seasons)
    {
      serializer: 'seasons',
      stat_record: seasons.maximum(:updated_at)
    }
  end

  def episodes_number_order
    episodes.sort_by { |episode| @object.episodes_number.index episode.id }
  end
end
