FactoryBot.define do
  factory :event, class: Event do
    asociation :educational_domain
    description "event1"
    location "CS"
    lat 57.0123924
    lng 9.991556199999991
    begin_at "2018-07-16 14:30:00"
    planner "ruskorps"
  end
end