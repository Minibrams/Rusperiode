class User < ApplicationRecord
  include OmniAuthable
  has_secure_password
end
