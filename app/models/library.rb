class Library < ApplicationRecord
  belongs_to :user
  has_many :library_contents
  has_many :contents, through: :library_contents

  def library_contents_by_order
    library_contents.alive.order(:expires_at)
  end
end
