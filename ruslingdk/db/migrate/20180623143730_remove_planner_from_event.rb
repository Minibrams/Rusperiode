class RemovePlannerFromEvent < ActiveRecord::Migration[5.1]
  def change
    remove_column :events, :planner
  end
end
