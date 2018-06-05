class User < ApplicationRecord
  include OmniAuthable

  belongs_to :educational_domain, optional: true
  has_many :pages, through: :educational_domain

  def name
    "#{firstname} #{lastname}"
  end
end
