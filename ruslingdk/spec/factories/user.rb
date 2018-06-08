FactoryBot.define do
  factory :user do
    firstname "firstname"
    lastname "lastname"
    email "firstlast@mail.dk"
    password_digest "yes"
    association :educational_domain
    domain_admin true
    system_admin true
  end
end