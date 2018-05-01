class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :title
      t.references :educational_domain, foreign_key: true
      t.string :description
      t.string :location
      t.decimal :lat, null: true, precision: 9, scale: 6
      t.decimal :lng, null: true, precision: 9, scale: 6
      t.datetime :begin_at, null: false

      t.timestamps
    end
  end
end
