class Season < Content
  has_many :episodes

  def episodes_number_order
    episodes.sort_by { |episode| episodes_number.index episode.id.to_s }
  end
end
