class CreateCsGoTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :cs_go_teams do |t|
      t.string :challonge_id
      t.datetime :exported_to_challonge
      t.jsonb :raw_data

      t.timestamps
    end
    add_index :cs_go_teams, :challonge_id
  end
end
