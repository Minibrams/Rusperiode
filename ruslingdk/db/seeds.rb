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
        "link" => "/faq",
        "image_url" => 'http://placekitten.com/200/200'
      },
      {
        "name" => "How To",
        "link" => "/howto",
        "image_url" => 'http://placekitten.com/300/300'
      },
      {
        "name" => "Arrangementer",
        "link" => "/events",
        "image_url" => 'http://placekitten.com/1920/1080'
      },
      {
        "name" => "Information",
        "link" => "/info",
        "image_url" => 'http://placekitten.com/500/500'
      },
      {
        "name" => "Vigtige Kontakter",
        "link" => "/kontakter",
        "image_url" => 'http://placekitten.com/600/600'
      },
      {
        "name" => "Gode Råd",
        "link" => "/advice",
        "image_url" => 'http://placekitten.com/700/200'
      }
    ]
  men.educational_domain = testdomain
  men.save


  pa = Page.create(educational_domain: testdomain, title: 'Test', content: 'Test')

  
  faq1_accordion = 

  faq_page = Page.create(slug: "faq", educational_domain_id: 2, title: 'FAQ', content: 'Her er svarene på alle jeres spørgmål!', view_file:"accordion")
  faq_page.accordion = [
    {
      "title" => "De første par dage",
      "content" => File.read(__dir__ + "/seeds/faq/studiestartsdagen.html")
    },
    {
      "title" => "Rusperioden",
      "content" => File.read(__dir__ + "/seeds/faq/rusperioden.html")
    },
    {
      "title" => "Studiet",
      "content" => File.read(__dir__ + "/seeds/faq/studiet.html")
    },
    {
      "title" => "Eksamen",
      "content" => File.read(__dir__ + "/seeds/faq/eksamen.html")
    }
  ]
  faq_page.save



  info_page = Page.create(slug: "info", educational_domain_id: 2, title: 'info', content: 'En masse informationer!', view_file:"accordion")
  info_page.accordion = [
    {
      "title" => "Studiestartsdagen",
      "content" => File.read(__dir__ + "/seeds/info/studiestartsdagen.html")
    },
    {
      "title" => "Studieordninger",
      "content" => File.read(__dir__ + "/seeds/info/studieordninger.html")
    },
    {
      "title" => "Studenterpolitik",
      "content" => File.read(__dir__ + "/seeds/info/studenterpolitik.html")
    },
    {
      "title" => "Ruskorpset",
      "content" => File.read(__dir__ + "/seeds/info/ruskorpset.html")
    },
    {
      "title" => "Samarbejdspartnere",
      "content" => File.read(__dir__ + "/seeds/info/samarbejdspartnere.html")
    }
  ]
  info_page.save

  howto_page = Page.create(slug: "howto", educational_domain_id: 2, title: 'info', content: 'En masse informationer!', view_file:"accordion")
  howto_page.accordion = [
    {
      "title" => "LaTeX",
      "content" => File.read(__dir__ + "/seeds/howto/latex.html")
    },
    {
      "title" => "WiFi",
      "content" => File.read(__dir__ + "/seeds/howto/wifi.html")
    },
    {
      "title" => "Studiekort",
      "content" => File.read(__dir__ + "/seeds/howto/studiekort.html")
    },
    {
      "title" => "Print",
      "content" => File.read(__dir__ + "/seeds/howto/print.html")
    },
    {
      "title" => "Skema",
      "content" => File.read(__dir__ + "/seeds/howto/skema.html")
    },
    {
      "title" => "Studiemail på telefon",
      "content" => File.read(__dir__ + "/seeds/howto/studiemail.html")
    },
    {
      "title" => "Moodle",
      "content" => File.read(__dir__ + "/seeds/howto/moodle.html")
    }
  ]
  howto_page.save

  contacts_page = Page.create(slug: "kontakter", educational_domain_id: 2, title: 'Vigtige Kontakter', content: 'Her er alle de mennesker der er vigtige!', view_file:"contacts")
  contacts_page.accordion = [
    {
      "name" => "Fornavn Efternavn",
      "email" => "sample@email.com",
      "nr" => "12345678",
      "image_url" => 'http://placekitten.com/1920/1080'
    },
    {
      "name" => "Fornavn Efternavn",
      "email" => "sample@email.com",
      "nr" => "12345678",
      "image_url" => 'http://placekitten.com/1920/1080'
    },
    {
      "name" => "Fornavn Efternavn",
      "email" => "sample@email.com",
      "nr" => "12345678",
      "image_url" => 'http://placekitten.com/1920/1080'
    },
    {
      "name" => "Fornavn Efternavn",
      "email" => "sample@email.com",
      "nr" => "12345678",
      "image_url" => 'http://placekitten.com/1920/1080'
    },
    {
      "name" => "Fornavn Efternavn",
      "email" => "sample@email.com",
      "nr" => "12345678",
      "image_url" => 'http://placekitten.com/1920/1080'
    }
  ]
  contacts_page.save

  advice_page = Page.create(slug: "advice", educational_domain_id: 2, title: 'Gode råd fra ældre studerende!', content: File.read(__dir__ + "/seeds/advice.html"), view_file:"show")

  ev1 = Event.create(title: "Ruskorps Event", educational_domain: testdomain, description: "<h5>Ruskorpset</h5>Holder et svedigt event!", location: "CS!", lat: 57.0123924, lng: 9.991556199999991, begin_at: "2018-05-16 14:30:00", planner: "ruskorps")
  ev2 = Event.create(title: "PROSA Event", educational_domain: testdomain, description: "Noget prosa arrangerer", location: "CS!", lat: 57.0123924, lng: 9.991556199999991, begin_at: "2018-05-18 14:30:00", planner: "prosa")
  ev3 = Event.create(title: "IDA Event", educational_domain: testdomain, description: "Noget ida arrangerer", location: "CS!", lat: 57.0123924, lng: 9.991556199999991, begin_at: "2018-05-20 14:30:00", planner: "ida")
  ev4 = Event.create(title: "Studentersamfundet Event", educational_domain: testdomain, description: "Noget studentersamfundet arrangerer", location: "CS!", lat: 57.0123924, lng: 9.991556199999991, begin_at: "2018-05-22 14:30:00", planner: "studentersamfundet")
  

  testdomain.update(primary_menu: men, default_page: pa)
end