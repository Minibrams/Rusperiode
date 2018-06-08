require 'rails_helper'

RSpec.describe EducationalDomain, type: :model do
  it { should have_many(:menus) }
  it { should have_many(:events) }
  it { should have_many(:pages) }

  it { should belong_to(:primary_menu).class_name('Menu') }
  it { should belong_to(:secondary_menu).class_name('Menu') }
end
