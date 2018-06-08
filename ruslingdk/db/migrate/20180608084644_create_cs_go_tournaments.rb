class CreateCsGoTournaments < ActiveRecord::Migration[5.1]
  def change
    create_table :cs_go_tournaments do |t|
      t.string :challonge_id
      t.jsonb :raw_data

      t.timestamps
    end
    add_index :cs_go_tournaments, :challonge_id
  end
end
