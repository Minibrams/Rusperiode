class CreateCsGoMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :cs_go_matches do |t|
      t.string :challonge_id
      t.jsonb :raw_data

      t.timestamps
    end
    add_index :cs_go_matches, :challonge_id
  end
end
