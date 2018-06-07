class EducationalDomain < ApplicationRecord
  # include Colorised
  has_many :menus
  has_many :events
  has_many :contacts

  belongs_to :primary_menu, class_name: 'Menu', optional: true
  belongs_to :secondary_menu, class_name: 'Menu', optional: true

  has_many :pages
  belongs_to :default_page, class_name: 'Page', optional: true
  # belongs_to :layout

  scope :default_domain, -> { where(domain: '192.38.56.109').first }


end
