class AddDefaultMenusForEducationDomains < ActiveRecord::Migration[5.1]
  def change
    add_column :educational_domains, :primary_menu_id, :integer, index: true
    add_foreign_key :educational_domains, :menus, column: :primary_menu_id, on_delete: :nullify

    add_column :educational_domains, :secondary_menu_id, :integer, index: true
    add_foreign_key :educational_domains, :menus, column: :secondary_menu_id, on_delete: :nullify
  end
end
