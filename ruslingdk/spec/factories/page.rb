FactoryBot.define do
  factory :page do
    slug "testpage"
    title "testtitle"
    content "testcontent"

    trait :with_domain do
      association :educational_domain
    end

    trait :accordion do
      slug "testaccordion"
      view_file "accordion"
      add_attribute(:accordion) {
        [{"title" => "testtitle", "content" => "testcontent"}, {"title" => "testtitle2", "content" => "testcontent2"}]
      }
    end

    trait :contacts do
      slug "testcontacts"
      view_file "contacts"
    end

    trait :frontpage do
      slug "testfrontpage"
      view_file "frontpage"
    end

    trait :index do
      slug "testindex"
      view_file "index"
    end

    trait :show do
      slug "testshow"
      view_file "show"
    end
  end
end

