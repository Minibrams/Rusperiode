require 'rails_helper'

RSpec.describe Page, type: :model do
  it { should belong_to(:educational_domain) }
  it { should validate_uniqueness_of(:slug).scoped_to(:educational_domain_id) }
end