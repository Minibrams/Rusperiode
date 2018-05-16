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
        "name" => "FAQ",
        "link" => "/",
        "image_url" => 'http://placekitten.com/200/200'
      },
      {
        "name" => "How To",
        "link" => "/",
        "image_url" => 'http://placekitten.com/300/300'
      },
      {
        "name" => "Arrangementer",
        "link" => "/events",
        "image_url" => 'http://placekitten.com/400/400'
      },
      {
        "name" => "Information",
        "link" => "/",
        "image_url" => 'http://placekitten.com/500/500'
      },
      {
        "name" => "Vigtige Kontakter",
        "link" => "/",
        "image_url" => 'http://placekitten.com/600/600'
      },
      {
        "name" => "Gode Råd",
        "link" => "#",
        "image_url" => 'http://placekitten.com/700/200'
      }
    ]
  men.educational_domain = testdomain
  men.save


  pa = Page.create(educational_domain: testdomain, title: 'Test', content: 'Test')

  ev1 = Event.create(title: "Ruskorps Event", educational_domain: testdomain, description: "<h5>Ruskorpset</h5>Holder et svedigt event!", location: "CS!", lat: 57.0123924, lng: 9.991556199999991, begin_at: "2018-05-16 14:30:00", planner: "ruskorps")
  ev2 = Event.create(title: "PROSA Event", educational_domain: testdomain, description: "Noget prosa arrangerer", location: "CS!", lat: 57.0123924, lng: 9.991556199999991, begin_at: "2018-05-18 14:30:00", planner: "prosa")
  ev3 = Event.create(title: "IDA Event", educational_domain: testdomain, description: "Noget ida arrangerer", location: "CS!", lat: 57.0123924, lng: 9.991556199999991, begin_at: "2018-05-20 14:30:00", planner: "ida")
  ev4 = Event.create(title: "Studentersamfundet Event", educational_domain: testdomain, description: "Noget studentersamfundet arrangerer", location: "CS!", lat: 57.0123924, lng: 9.991556199999991, begin_at: "2018-05-22 14:30:00", planner: "studentersamfundet")
  

  testdomain.update(primary_menu: men, default_page: pa)
end