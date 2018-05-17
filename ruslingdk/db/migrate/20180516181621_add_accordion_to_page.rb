class AddAccordionToPage < ActiveRecord::Migration[5.1]
  def change
    add_column :pages, :accordion, :jsonb
  end
end
