class Event < ApplicationRecord
  belongs_to :educational_domain, dependent: :destroy

  scope :upcoming, -> { where('DATE(begin_at) > ?', Date.today) }
  scope :today, -> { where('DATE(begin_at) = ?', Date.today) }
  scope :previous, -> { where('DATE(begin_at) < ?', Date.today) }

end
