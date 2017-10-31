class Page < ApplicationRecord
  belongs_to :educational_domain
  validates_format_of :slug, with: /\A[\w\/]+\z/
  validates_uniqueness_of :slug
end
