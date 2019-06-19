class CreateContents < ActiveRecord::Migration[5.2]
  def change
    create_table :contents do |t|
      t.string :title
      t.string :plot
      t.string :type
      t.text :episodes_number, array: true, default: []

      t.timestamps
    end
  end
end
