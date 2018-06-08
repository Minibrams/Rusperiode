class RuslingAuthorization < ActiveAdmin::AuthorizationAdapter
  def authorized?(action, subject = nil)
    return true if user.system_admin?

    if subject.is_a?(::User)
      return true if subject == user
      if user.domain_admin?
        return true if subject.educational_domain == user.educational_domain
      end
    end

    if subject.is_a?(::EducationalDomain)
      return true if subject == user.educational_domain
    end

    if subject.is_a?(::Event)
      return true if subject.educational_domain == user.educational_domain
    end

    if subject.is_a?(::Page)
      return true if subject.educational_domain == user.educational_domain
    end

    if subject.is_a?(::Menu)
      return true if subject.educational_domain == user.educational_domain
    end

    if subject.is_a?(::ActiveAdmin::Page)
      return action == :read if subject.name == 'Dashboard'
    end

    if [User, EducationalDomain, Event, Page, Menu].include? subject
      return action == :read
    end

    false
  end
end
