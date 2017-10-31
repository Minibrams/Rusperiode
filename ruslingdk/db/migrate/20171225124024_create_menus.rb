class CreateMenus < ActiveRecord::Migration[5.1]
  def change
    create_table :menus do |t|
      t.string :name
      t.jsonb :items
      t.references :educational_domain, foreign_key: true

      t.timestamps
    end
  end
end
