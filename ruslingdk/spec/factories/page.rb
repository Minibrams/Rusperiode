FactoryBot.define do
  factory :page do
    slug "testaccordion"
    view_file "accordion"
    title "testpage"
    content "testcontent"
    association :educational_domain
    add_attribute(:accordion) {
      [{"title" => "testtitle", "content" => "testcontent"}, {"title" => "testtitle2", "content" => "testcontent2"}]
    }
  end

end

