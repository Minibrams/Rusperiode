require 'active_support/concern'

module OmniAuthable
  extend ActiveSupport::Concern

  included do
    has_secure_password
  end

  class_methods do
    def find_or_create_from_authhash(authhash)
      return self.send("provider_#{authhash.provider}") if self.respond_to?("provider_#{authhash.provider}")
      nil
    end
  end
end