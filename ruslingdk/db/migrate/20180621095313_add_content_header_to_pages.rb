class AddContentHeaderToPages < ActiveRecord::Migration[5.1]
  def change
    add_column :pages, :content_header, :string
  end
end
