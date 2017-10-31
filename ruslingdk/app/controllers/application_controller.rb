class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_domain

  private

  def set_domain
    @domain = Rails.cache.fetch("DomainCache/#{request.host}", expires_in: 12.hours) do
      EducationalDomain.find_by(domain: request.host) || EducationalDomain.default_domain
    end
  end
end
