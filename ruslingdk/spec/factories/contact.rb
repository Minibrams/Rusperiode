FactoryBot.define do
  factory :contact, class: Contact do
    association :educational_domain
    name "Firstname Lastname"
    email "firstlast@mail.dk"
    number "88 88 88 88"
    description "description"
    image "http://placekitten.com/500/500"
  end
end