class User < ApplicationRecord
  include OmniAuthable

  def name
    "#{firstname} #{lastname}"
  end
end
