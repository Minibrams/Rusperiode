class AddMissingUserMigrations < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :educational_domain, foreign_key: true
    add_column :users, :domain_admin, :boolean, default: false
    add_column :users, :system_admin, :boolean, default: false
  end
end
