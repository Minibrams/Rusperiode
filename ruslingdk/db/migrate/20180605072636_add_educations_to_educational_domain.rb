class AddEducationsToEducationalDomain < ActiveRecord::Migration[5.1]
  def change
    add_column :educational_domains, :educations, :text, array:true, default: []
  end
end
