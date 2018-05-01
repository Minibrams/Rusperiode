require 'active_support/concern'

module OmniAuthable
  extend ActiveSupport::Concern

  included do
    has_many :oauth_logins
    has_secure_password validations: false
    validates :password, length: { minimum: 8 }, allow_blank: true
  end

  class_methods do
    def find_or_create_from_auth_hash(authhash)
      return self.send("provider_#{authhash[:provider]}", authhash) if self.respond_to?("provider_#{authhash[:provider]}")
      nil
    end

    # Providers:
    def provider_developer(authhash = {})
      u = User.find_by(email: authhash.email)
      return u if u.oauth_logins.where(provider: 'developer', token: authhash.token).exists?
    end

    def provider_github(authhash = {})
      oauth_login(authhash)&.user || create_from_hash(authhash)
    end

    def provider_facebook(authhash = {})
      # Fix for Facebook parsing expires_at date.
      authhash[:credentials][:expires_at] = DateTime.strptime authhash[:credentials][:expires_at].to_s, '%s'
      oauth_login(authhash)&.user || create_from_hash(authhash)
    end

    def provider_login(authhash = {})
      oauth_login(authhash)&.user.try(:authenticate, authhash[:info][:password]) || nil
    end

    def oauth_login(authhash)
      OauthLogin.where(provider: authhash[:provider])
                .where('expires_at IS NULL OR expires_at >= ?', authhash[:credentials][:expires_at])
                .where(uid: authhash[:uid])
                .first
    end

    def create_from_hash(authhash = {})
      return nil if User.where(email: authhash[:info][:email]).exists?
      # No user present - Proceed with creating a new one.
      this = self.new
      ApplicationRecord.transaction do
        this.firstname = authhash[:info][:first_name] if this.respond_to?(:firstname=)
        this.lastname = authhash[:info][:last_name] if this.respond_to?(:lastname=)

        if authhash[:info][:name]
          this.firstname = authhash[:info][:name].split.first if this.respond_to?(:firstname=) && this.firstname.blank?
          this.lastname = authhash[:info][:name].split[1..-1].join(' ') if this.respond_to?(:lastname=) && this.lastname.blank?
        end

        this.email = authhash[:info][:email] if this.respond_to?(:email=)
        this.save

        this.oauth_logins.create!(
          provider: authhash[:provider],
          uid: authhash[:uid],
          token: authhash[:credentials][:token],
          secret: authhash[:credentials][:secret],
          expires_at: authhash[:credentials][:expires] ? authhash[:credentials][:expires_at] : nil,
          raw_data: authhash[:extra][:raw_info]
        )
      end

      this
    end
  end
end
