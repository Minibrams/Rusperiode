class AddPlannerToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :planner, :string, default: "ruskorps"
  end
end
