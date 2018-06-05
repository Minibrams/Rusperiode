class Page < ApplicationRecord
  belongs_to :educational_domain
  validates_format_of :slug, with: /\A[\w\/]{0,}\z/
  validates_uniqueness_of :slug, scope: :educational_domain_id
end
