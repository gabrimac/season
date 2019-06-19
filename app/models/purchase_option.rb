class PurchaseOption < ApplicationRecord
  belongs_to :content

  enum quality: %i[sd hd]
end
