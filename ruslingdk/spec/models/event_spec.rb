require 'rails_helper'

RSpec.describe Event, type: :model do
  it { should belong_to(:educational_domain).dependent(:destroy) }
end
