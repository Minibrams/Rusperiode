class EducationalDomain < ApplicationRecord
  has_many :pages
  scope :default_domain, -> { where(domain: 'rusling.dk').first }

end
