require 'rails_helper'

RSpec.describe User, type: :model do
  it { should belong_to(:educational_domain) }
  it { should have_many(:oauth_logins) }
end
