class LibraryContent < ApplicationRecord
  belongs_to :content
  belongs_to :library

  def self.alive
    where('expires_at >= ?', Date.today)
  end
end
