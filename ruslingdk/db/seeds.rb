# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

dom = EducationalDomain.find_or_initialize_by(domain: 'rusling.dk')
dom.name = 'Datalogi/Software'
dom.save

menprod = Menu.create(
  name: "Ting",
  items: [],
  educational_domain: dom
)
dom.update(primary_menu: menprod)


if Rails.env.development?
  testdomain = EducationalDomain.find_or_initialize_by(domain: 'localhost')
  testdomain.name = 'Spang Faktultet Test'
  testdomain.save
  men = Menu.find_or_initialize_by(name: "Test Menu")
  men.items = [
      {
        "name" => "Forside",
        "link" => "/"
      },
      {
        "name" => "Vigtige links",
        "link" => '#',
        "dropdown" => [
          {
            "name" => "Stack Overflow",
            "link" => "https://stackoverflow.com"
          },
          {
            "name" => "Google",
            "link" => "https://google.com"
          }
        ]
      }
    ]
  men.educational_domain = testdomain
  men.save

  pa = Page.create(educational_domain: testdomain, title: 'TestTitle', content: 'Seedcontent')

  testdomain.update(primary_menu: men, default_page: pa)
end