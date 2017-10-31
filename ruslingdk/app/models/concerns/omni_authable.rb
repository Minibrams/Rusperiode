module OmniAuthable
  def self.included(base)
    base.extend ClassMethods
    base.class_eval do
      scope :disabled, -> { where(disabled: true) }
    end
  end

  module ClassMethods
    def find_or_create_from_authhash(authhash)
      return self.send("provider_#{authhash.provider}") if self.respond_to?("provider_#{authhash.provider}")
      nil
    end

    def provider_developer
      # returns User
    end
  end
end
