class AddDefaultPageToEducationalDomain < ActiveRecord::Migration[5.1]
  def change
    add_column :educational_domains, :default_page_id, :bigint
    add_index :educational_domains, :default_page_id
  end
end
