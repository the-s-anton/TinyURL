class CreateClicks < ActiveRecord::Migration[7.0]
  def change
    create_table :clicks do |t|
      t.references :url, null: false, foreign_key: true, index: true
      t.string :ip_address

      t.timestamps
    end
  end
end
