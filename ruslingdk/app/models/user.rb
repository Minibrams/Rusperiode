class User < ApplicationRecord
  include OmniAuthable

  belongs_to :educational_domain, optional: true

  def name
    "#{firstname} #{lastname}"
  end
end
