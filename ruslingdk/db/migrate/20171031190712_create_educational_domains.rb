class CreateEducationalDomains < ActiveRecord::Migration[5.1]
  def change
    create_table :educational_domains do |t|
      t.string :name
      t.string :domain

      t.timestamps
    end
    add_index :educational_domains, :domain
  end
end
