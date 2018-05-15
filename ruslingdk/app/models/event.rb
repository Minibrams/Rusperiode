class Event < ApplicationRecord
  belongs_to :educational_domain, dependent: :destroy
  scope :active, -> { where('begin_at >= ?', Time.now) }
  validates :planner, inclusion: {in: ["prosa", "ruskorps", "ida", "studentersamfundet"]}
end
