class AddViewFileToPages < ActiveRecord::Migration[5.1]
  def change
    add_column :pages, :view_file, :string
  end
end
