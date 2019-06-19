class CreatePurchaseOptions < ActiveRecord::Migration[5.2]
  def change
    create_table :purchase_options do |t|
      t.float :price
      t.integer :quality
      t.integer :content_id

      t.timestamps
    end
  end
end
