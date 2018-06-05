class AddLocaleToEducationalDomain < ActiveRecord::Migration[5.1]
  def change
    add_column :educational_domains, :locale, :string
  end
end
