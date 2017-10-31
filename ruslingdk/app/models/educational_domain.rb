class EducationalDomain < ApplicationRecord
  has_many :pages
  belongs_to :default_page, class_name: 'Page', optional: true
  scope :default_domain, -> { where(domain: 'rusling.dk').first }

end
