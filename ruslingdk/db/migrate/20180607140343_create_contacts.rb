class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :number
      t.string :email
      t.string :description
      t.string :image
      t.references :educational_domain, foreign_key: true
    end
  end
end
