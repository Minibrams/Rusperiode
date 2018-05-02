require 'rails_helper'

RSpec.describe OauthLogin, type: :model do
  it { should belong_to(:user) }
end