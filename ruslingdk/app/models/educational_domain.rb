class EducationalDomain < ApplicationRecord
  # include Colorised
  has_many :menus
  belongs_to :primary_menu, class_name: 'Menu'
  belongs_to :secondary_menu, class_name: 'Menu'

  has_many :pages
  belongs_to :default_page, class_name: 'Page', optional: true
  # belongs_to :layout

  scope :default_domain, -> { where(domain: 'rusling.dk').first }
end
