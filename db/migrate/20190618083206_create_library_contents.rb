class CreateLibraryContents < ActiveRecord::Migration[5.2]
  def change
    create_table :library_contents do |t|
      t.integer :content_id
      t.integer :library_id
      t.date :expires_at
      t.string :quality

      t.timestamps
    end

    add_index :library_contents, %i[content_id library_id]
  end
end
