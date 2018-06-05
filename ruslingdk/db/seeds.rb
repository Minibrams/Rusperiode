# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Rails.env.production?
  dom = EducationalDomain.find_or_initialize_by(domain: 'rusling.dk')
  dom.colors = {"primary-color" => "#FF8C00"}
  dom.name = 'Datalogi/Software'
  dom.locale = 'da'
  dom.save!

  menprod = Menu.create(
    name: "Ting",
    items: [],
    educational_domain: dom
  )
  dom.update(primary_menu: menprod)
end

if Rails.env.development?
#Forside
  frontpageDomain = EducationalDomain.find_or_initialize_by(domain: 'localhost')
  frontpageDomain.name = 'rusling.dk'
  frontpageDomain.colors = {"primary-color" => "#211a52"}
  frontpageDomain.locale = "en"
  frontpageDomain.save

  fppage = Page.create!(educational_domain: frontpageDomain, title: 'rusling.dk', content: 'Velkommen til rusling.dk <br>Find din uddannelse i oversigten nedenunder!', view_file: "frontpage")
  frontpageDomain.update!(default_page: fppage)


#Tech
  #DatSW
  datswdomain = EducationalDomain.find_or_initialize_by(domain: 'datsw.localhost')
  datswdomain.name = 'Datalogi og Software'
  datswdomain.educations = ["Datalogi", "Software"]
  datswdomain.colors = {"primary-color" => "#FF8C00"}
  datswdomain.locale = "da"
  datswdomain.save

  men = datswdomain.menus.find_or_initialize_by(name: "Test Menu")
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
  men.educational_domain = datswdomain
  men.save

  pa = Page.create(educational_domain: datswdomain, title: 'Test', content: 'Test', view_file: "index")

  faq_page = Page.create(slug: "faq", educational_domain: datswdomain, title: 'FAQ', content: 'Her er svarene på alle jeres spørgmål!', view_file:"accordion")
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

  info_page = Page.create(slug: "info", educational_domain: datswdomain, title: 'info', content: 'En masse informationer!', view_file:"accordion")
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

  howto_page = Page.create(slug: "howto", educational_domain: datswdomain, title: 'info', content: 'En masse informationer!', view_file:"accordion")
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

  contacts_page = Page.create(slug: "kontakter", educational_domain: datswdomain, title: 'Vigtige Kontakter', content: 'Her er alle de mennesker der er vigtige!', view_file:"contacts")
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

  advice_page = Page.create(slug: "advice", educational_domain: datswdomain, title: 'Gode råd fra ældre studerende!', content: File.read(__dir__ + "/seeds/advice.html"), view_file:"show")

  ev1 = Event.create(title: "Ruskorps Event", educational_domain: datswdomain, description: "<h5>Ruskorpset</h5>Holder et svedigt event!", location: "CS!", lat: 57.0123924, lng: 9.991556199999991, begin_at: "2018-05-16 14:30:00", planner: "ruskorps")
  ev2 = Event.create(title: "PROSA Event", educational_domain: datswdomain, description: "Noget prosa arrangerer", location: "CS!", lat: 57.0123924, lng: 9.991556199999991, begin_at: "2018-05-18 14:30:00", planner: "prosa")
  ev3 = Event.create(title: "IDA Event", educational_domain: datswdomain, description: "Noget ida arrangerer", location: "CS!", lat: 57.0123924, lng: 9.991556199999991, begin_at: "2018-05-20 14:30:00", planner: "ida")
  ev4 = Event.create(title: "Studentersamfundet Event", educational_domain: datswdomain, description: "Noget studentersamfundet arrangerer", location: "CS!", lat: 57.0123924, lng: 9.991556199999991, begin_at: "2018-05-22 14:30:00", planner: "studentersamfundet")


  datswdomain.update(primary_menu: men, default_page: pa)

#Eng
engdomain = EducationalDomain.find_or_initialize_by(domain: 'eng.localhost')
  engdomain.name = 'Engeneering'
  engdomain.educations = ["Matematik", "Fysik", "Matematik-Økonomi", "Noget andet"]
  engdomain.colors = {"primary-color" => "#00FF00"}
  engdomain.locale = "da"
  engdomain.save

  meneng = engdomain.menus.find_or_initialize_by(name: "Eng Menu")
  meneng.items = [
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
  meneng.educational_domain = engdomain
  meneng.save

  paeng = Page.create(educational_domain: engdomain, title: 'Test', content: 'Test', view_file: "index")

  faqeng_page = Page.create(slug: "faq", educational_domain: engdomain, title: 'FAQ', content: 'Her er svarene på alle jeres spørgmål!', view_file:"accordion")
  faqeng_page.accordion = [
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
  faqeng_page.save

  infoeng_page = Page.create(slug: "info", educational_domain: engdomain, title: 'info', content: 'En masse informationer!', view_file:"accordion")
  infoeng_page.accordion = [
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
  infoeng_page.save

  howtoeng_page = Page.create(slug: "howto", educational_domain: engdomain, title: 'info', content: 'En masse informationer!', view_file:"accordion")
  howtoeng_page.accordion = [
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
  howtoeng_page.save

  contactseng_page = Page.create(slug: "kontakter", educational_domain: engdomain, title: 'Vigtige Kontakter', content: 'Her er alle de mennesker der er vigtige!', view_file:"contacts")
  contactseng_page.accordion = [
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
  contactseng_page.save

  adviceeng_page = Page.create(slug: "advice", educational_domain: engdomain, title: 'Gode råd fra ældre studerende!', content: File.read(__dir__ + "/seeds/advice.html"), view_file:"show")

  ev1eng = Event.create(title: "Ruskorps Event", educational_domain: engdomain, description: "<h5>Ruskorpset</h5>Holder et svedigt event!", location: "CS!", lat: 57.0123924, lng: 9.991556199999991, begin_at: "2018-05-16 14:30:00", planner: "ruskorps")
  ev2eng = Event.create(title: "PROSA Event", educational_domain: engdomain, description: "Noget prosa arrangerer", location: "CS!", lat: 57.0123924, lng: 9.991556199999991, begin_at: "2018-05-18 14:30:00", planner: "prosa")
  ev3eng = Event.create(title: "IDA Event", educational_domain: engdomain, description: "Noget ida arrangerer", location: "CS!", lat: 57.0123924, lng: 9.991556199999991, begin_at: "2018-05-20 14:30:00", planner: "ida")
  ev4eng = Event.create(title: "Studentersamfundet Event", educational_domain: engdomain, description: "Noget studentersamfundet arrangerer", location: "CS!", lat: 57.0123924, lng: 9.991556199999991, begin_at: "2018-05-22 14:30:00", planner: "studentersamfundet")


  engdomain.update(primary_menu: meneng, default_page: paeng)


#Hum
  humdomain = EducationalDomain.find_or_initialize_by(domain: 'hum.localhost')
  humdomain.name = 'Humaniora'
  humdomain.educations = ["Dansk", "Engelsk", "Tysk", "Svensk", "Norsk", "Historie"]
  humdomain.colors = {"primary-color" => "#FF0000"}
  humdomain.locale = "en"
  humdomain.save

  menhum = humdomain.menus.find_or_initialize_by(name: "Hum Menu")
  menhum.items = [
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
  menhum.educational_domain = humdomain
  menhum.save

  fphum_page = Page.create(educational_domain: humdomain, title: 'test', content: 'hej!', view_file: "index")
  faqhum_page = Page.create(slug: "faq", educational_domain: humdomain, title: 'FAQ', content: 'Her er svarene på alle jeres spørgmål!', view_file:"accordion")
  faqhum_page.accordion = [
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
  faqhum_page.save

  infohum_page = Page.create(slug: "info", educational_domain: humdomain, title: 'info', content: 'En masse informationer!', view_file:"accordion")
  infohum_page.accordion = [
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
  infohum_page.save

  howtohum_page = Page.create(slug: "howto", educational_domain: humdomain, title: 'info', content: 'En masse informationer!', view_file:"accordion")
  howtohum_page.accordion = [
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
  howtohum_page.save

  contactshum_page = Page.create(slug: "kontakter", educational_domain: humdomain, title: 'Vigtige Kontakter', content: 'Her er alle de mennesker der er vigtige!', view_file:"contacts")
  contactshum_page.accordion = [
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
  contactshum_page.save

  advicehum_page = Page.create(slug: "advice", educational_domain: datswdomain, title: 'Gode råd fra ældre studerende!', content: File.read(__dir__ + "/seeds/advice.html"), view_file:"show")


  ev1hum = Event.create(title: "Ruskorps Event", educational_domain: humdomain, description: "<h5>Ruskorpset</h5>Holder et svedigt event!", location: "CS!", lat: 57.0123924, lng: 9.991556199999991, begin_at: "2018-05-16 14:30:00", planner: "ruskorps")
  ev2hum = Event.create(title: "PROSA Event", educational_domain: humdomain, description: "Noget prosa arrangerer", location: "CS!", lat: 57.0123924, lng: 9.991556199999991, begin_at: "2018-05-18 14:30:00", planner: "prosa")
  ev3hum = Event.create(title: "IDA Event", educational_domain: humdomain, description: "Noget ida arrangerer", location: "CS!", lat: 57.0123924, lng: 9.991556199999991, begin_at: "2018-05-20 14:30:00", planner: "ida")
  ev4hum = Event.create(title: "Studentersamfundet Event", educational_domain: humdomain, description: "Noget studentersamfundet arrangerer", location: "CS!", lat: 57.0123924, lng: 9.991556199999991, begin_at: "2018-05-22 14:30:00", planner: "studentersamfundet")

  humdomain.update(primary_menu: menhum ,default_page: fphum_page)

#Samf
samfdomain = EducationalDomain.find_or_initialize_by(domain: 'samf.localhost')
  samfdomain.name = 'Samfundsvidenskab'
  samfdomain.educations = ["Kommunikation", "Uddannelse2", "Uddannelse3", "Uddannelse4"]
  samfdomain.colors = {"primary-color" => "#0000FF"}
  samfdomain.locale = "da"
  samfdomain.save


  mensamf = samfdomain.menus.find_or_initialize_by(name: "Samf Menu")

  mensamf.items = [
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
  mensamf.educational_domain = samfdomain
  mensamf.save

  pasamf = Page.create(educational_domain: samfdomain, title: 'Test', content: 'Test', view_file: "index")

  faqsamf_page = Page.create(slug: "faq", educational_domain: samfdomain, title: 'FAQ', content: 'Her er svarene på alle jeres spørgmål!', view_file:"accordion")
  faqsamf_page.accordion = [
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
  faqsamf_page.save

  infosamf_page = Page.create(slug: "info", educational_domain: samfdomain, title: 'info', content: 'En masse informationer!', view_file:"accordion")
  infosamf_page.accordion = [
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
  infosamf_page.save

  howtosamf_page = Page.create(slug: "howto", educational_domain: samfdomain, title: 'info', content: 'En masse informationer!', view_file:"accordion")
  howtosamf_page.accordion = [
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
  howtosamf_page.save

  contactssamf_page = Page.create(slug: "kontakter", educational_domain: samfdomain, title: 'Vigtige Kontakter', content: 'Her er alle de mennesker der er vigtige!', view_file:"contacts")
  contactssamf_page.accordion = [
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
  contactssamf_page.save

  advicesamf_page = Page.create(slug: "advice", educational_domain: samfdomain, title: 'Gode råd fra ældre studerende!', content: File.read(__dir__ + "/seeds/advice.html"), view_file:"show")

  ev1samf = Event.create(title: "Ruskorps Event", educational_domain: samfdomain, description: "<h5>Ruskorpset</h5>Holder et svedigt event!", location: "CS!", lat: 57.0123924, lng: 9.991556199999991, begin_at: "2018-05-16 14:30:00", planner: "ruskorps")
  ev2samf = Event.create(title: "PROSA Event", educational_domain: samfdomain, description: "Noget prosa arrangerer", location: "CS!", lat: 57.0123924, lng: 9.991556199999991, begin_at: "2018-05-18 14:30:00", planner: "prosa")
  ev3samf = Event.create(title: "IDA Event", educational_domain: samfdomain, description: "Noget ida arrangerer", location: "CS!", lat: 57.0123924, lng: 9.991556199999991, begin_at: "2018-05-20 14:30:00", planner: "ida")
  ev4samf = Event.create(title: "Studentersamfundet Event", educational_domain: samfdomain, description: "Noget studentersamfundet arrangerer", location: "CS!", lat: 57.0123924, lng: 9.991556199999991, begin_at: "2018-05-22 14:30:00", planner: "studentersamfundet")


  samfdomain.update(primary_menu: mensamf, default_page: pasamf)


#Sund
sunddomain = EducationalDomain.find_or_initialize_by(domain: 'sund.localhost')
  sunddomain.name = 'Sund'
  sunddomain.educations = ["Idræt", "Medicin", "MEDIS", "Uddannelse42", "Uddannelse43"]
  sunddomain.colors = {"primary-color" => "#FFFF00"}
  sunddomain.locale = "en"
  sunddomain.save


  mensund = sunddomain.menus.find_or_initialize_by(name: "Sund Menu")

  mensund.items = [
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
  mensund.educational_domain = sunddomain
  mensund.save

  pasund = Page.create(educational_domain: sunddomain, title: 'Test', content: 'Test', view_file: "index")

  faqsund_page = Page.create(slug: "faq", educational_domain: sunddomain, title: 'FAQ', content: 'Her er svarene på alle jeres spørgmål!', view_file:"accordion")
  faqsund_page.accordion = [
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
  faqsund_page.save

  infosund_page = Page.create(slug: "info", educational_domain: sunddomain, title: 'info', content: 'En masse informationer!', view_file:"accordion")
  infosund_page.accordion = [
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
  infosund_page.save

  howtosund_page = Page.create(slug: "howto", educational_domain: sunddomain, title: 'info', content: 'En masse informationer!', view_file:"accordion")
  howtosund_page.accordion = [
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
  howtosund_page.save

  contactssund_page = Page.create(slug: "kontakter", educational_domain: sunddomain, title: 'Vigtige Kontakter', content: 'Her er alle de mennesker der er vigtige!', view_file:"contacts")
  contactssund_page.accordion = [
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
  contactssund_page.save

  advicesund_page = Page.create(slug: "advice", educational_domain: sunddomain, title: 'Gode råd fra ældre studerende!', content: File.read(__dir__ + "/seeds/advice.html"), view_file:"show")

  ev1sund = Event.create(title: "Ruskorps Event", educational_domain: sunddomain, description: "<h5>Ruskorpset</h5>Holder et svedigt event!", location: "CS!", lat: 57.0123924, lng: 9.991556199999991, begin_at: "2018-05-16 14:30:00", planner: "ruskorps")
  ev2sund = Event.create(title: "PROSA Event", educational_domain: sunddomain, description: "Noget prosa arrangerer", location: "CS!", lat: 57.0123924, lng: 9.991556199999991, begin_at: "2018-05-18 14:30:00", planner: "prosa")
  ev3sund = Event.create(title: "IDA Event", educational_domain: sunddomain, description: "Noget ida arrangerer", location: "CS!", lat: 57.0123924, lng: 9.991556199999991, begin_at: "2018-05-20 14:30:00", planner: "ida")
  ev4sund = Event.create(title: "Studentersamfundet Event", educational_domain: sunddomain, description: "Noget studentersamfundet arrangerer", location: "CS!", lat: 57.0123924, lng: 9.991556199999991, begin_at: "2018-05-22 14:30:00", planner: "studentersamfundet")


  sunddomain.update(primary_menu: mensund, default_page: pasund)

end