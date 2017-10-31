class CreatePages < ActiveRecord::Migration[5.1]
  def change
    create_table :pages do |t|
      t.string :slug
      t.string :title
      t.text :content
      t.references :educational_domain

      t.timestamps
    end
    add_index :pages, :slug
  end
end
