class Content < ApplicationRecord
  has_many :library_contents
  has_many :libraries, through: :library_contents
  has_one :purchase
end
