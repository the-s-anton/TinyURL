class CreateUrls < ActiveRecord::Migration[7.0]
  def change
    create_table :urls do |t|
      t.string :original
      t.string :shortened, unique: true
      t.integer :clicks_count, default: 0
      t.integer :clicks_count_unique, default: 0

      t.timestamps
    end
  end
end
