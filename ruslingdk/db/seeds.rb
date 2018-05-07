# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

dom = EducationalDomain.create(domain: 'rusling.dk', name: 'Datalogi/Software')
menprod = Menu.create(
  name: "Ting",
  items: [],
  educational_domain: dom
)
dom.update(primary_menu: menprod)


if Rails.env.development?
  testdomain = EducationalDomain.create(domain: 'localhost', name: 'Spang Faktultet Test')
  men = Menu.create(name: "Test Menu", items: [], educational_domain: testdomain)
  pa = Page.create(educational_domain: testdomain, title: 'TestTitle', content: 'Seedcontent')

  testdomain.update(primary_menu: men, default_page: pa)
end