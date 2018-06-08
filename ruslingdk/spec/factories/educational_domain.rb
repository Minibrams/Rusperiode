FactoryBot.define do
  factory :educational_domain do
    domain "localhost"
    name "testdomain"
    colors {"#FFFFFF"}
    educations ["uddannelse1", "uddannelse2", "uddannelse3"]
    locale "da"

  end
end