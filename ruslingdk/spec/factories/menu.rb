FactoryBot.define do
  factory :menu, class: Menu do
    name "testmenu"
    items [{
      "name" => "Test1",
      "link" => "/test1",
      "image_url" => 'http://placekitten.com/200/200'
    },
    {
      "name" => "Test2",
      "link" => "/test2",
      "image_url" => 'http://placekitten.com/300/300'
    },
    {
      "name" => "Test3",
      "link" => "/test3",
      "image_url" => 'http://placekitten.com/1920/1080'
    }]
    association :educational_domain
  end
end