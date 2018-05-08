class Menu < ApplicationRecord
  belongs_to :educational_domain
  validates :planner, inclusion: {in: ["prosa", "ruskorps", "ida", "studentersamfundet"]}
end
