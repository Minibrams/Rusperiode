require 'redcarpet'

def html_parse(input, parser)
  if (parser == "textile")
    RedCloth.new(input).to_html
  elsif (parser == "markdown")
    options = {
      filter_html:     true,
      hard_wrap:       true,
      link_attributes: { rel: 'nofollow', target: "_blank" },
      space_after_headers: true,
      fenced_code_blocks: true
    }

    extensions = {
      autolink:           true,
      superscript:        true,
      disable_indented_code_blocks: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)
    markdown.render(input)
  else
    raise "Parser not supported, please try again (markdown/textile)"
  end
end


def create_datsw(domain)
  datswdomain = EducationalDomain.find_or_initialize_by(domain: domain)
  datswdomain.name = 'Datalogi og Software'
  datswdomain.educations = ["Datalogi", "Software"]
  datswdomain.colors = {"primary-color" => "#FF5000", "secondary-color" => "#FF9B33"}
  datswdomain.locale = "da"
  datswdomain.save

  datswmenu = datswdomain.menus.find_or_initialize_by(name: "DatSW Menu")
  datswmenu.items = [
    {
      "name" => "Vigtig viden",
      "description" => "(FAQ)",
      "link" => "/faq",
      "image_url" => 'vigtigviden.png'
    },
    {
      "name" => "Information",
      "description" => "Alt om studiestartsdagen osv.",
      "link" => "/info",
      "image_url" => ''
    },
    {
      "name" => "Arrangementer",
      "description" => "Se kalenderen over de kommende arrangementer",
      "link" => "/events",
      "image_url" => 'arrangementer.png'
    },
    {
      "name" => "Kontakt",
      "description" => "Få overblik over hvem du kan kontakte",
      "link" => "/kontakter",
      "image_url" => ''
    },
    {
      "name" => "Guides",
      "description" => "Hjælp til print, Wifi osv.",
      "link" => "/howto",
      "image_url" => 'guides.png'
    },
    {
      "name" => "Gode råd",
      "description" => "Kloge ord fra andre studerende",
      "link" => "/advice",
      "image_url" => 'goderaad.png'
    }
    ]
  datswmenu.educational_domain = datswdomain
  datswmenu.save

  #Contacts
  tobias = Contact.create(educational_domain: datswdomain, name: "Tobias Palludan", email: "tpallu16@student.aau.dk", number: "20 58 21 14", description: "Tobias kan hjælpe med alt!", image: "http://placekitten.com/500/500")
  spang = Contact.create(educational_domain: datswdomain, name: "Frederik Spang Thomsen", email: "fspang16@student.aau.dk", description: "Spang kan kode i rails!", image: "http://placekitten.com/250/500")
  brams = Contact.create(educational_domain: datswdomain, name: "Anders Brams", email: "abrams15@student.aau.dk", description: "Brams er champion!", image: "http://placekitten.com/500/700")
  kurt = Contact.create(educational_domain: datswdomain, name: "Kurt Nørmark", email: "normark@cs.aau.dk", description: "Du kan skrive til Kurt hvis du har spørgsmål vedr. alt der har med studiet, grupper og projekter at gøre.", image: "http://placekitten.com/1080/500")
  anders = Contact.create(educational_domain: datswdomain, name: "Anders Madsen", email: "amads15@student.aau.dk", number: "31 61 79 58", description: "Anders er toxic af!", image: "http://placekitten.com/1200/500")

  #Sponsors
  sponsor1 = Sponsor.create(educational_domain: datswdomain, name: "progras", image: "progras.png")
  sponsor2 = Sponsor.create(educational_domain: datswdomain, name: "progras", image: "prosa.png")
  sponsor3 = Sponsor.create(educational_domain: datswdomain, name: "progras", image: "cego.png")


  pa = Page.create(educational_domain: datswdomain, title: 'Datalogi og Software', content_header: '<h4>Velkommen til Rusling.dk</h4>', content: 'Vi gør alt hvad vi kan for at i kan få en fantastisk start på jeres studie! Her på siden har vi forsøgt at samle alle de informationer i kunne få brug for!<br><em>&ndash; Tutorerne</em>', view_file: "index")

  faq_page = Page.create(slug: "faq", educational_domain: datswdomain, title: 'Vigtig viden (FAQ)', content_header: '<h4>Her er svarene på alle jeres spørgmål!</h4>', view_file:"accordion")
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

  info_page = Page.create(slug: "info", educational_domain: datswdomain, title: 'Information', content_header: '<h4>Vi har samlet så mange informationer som mulig!</h4>', content: 'Hvis i synes der mangler noget, må i gerne sige til!', view_file:"accordion")
  info_page.accordion = [
    {
      "title" => "Studiestartsdagen",
      "content" => html_parse(File.read(__dir__ + "/seeds/info/studiestartsdagen.md"), "markdown")
    },
    {
      "title" => "Studieordninger",
      "content" => File.read(__dir__ + "/seeds/info/studieordninger.html")
    },
    {
      "title" => "Studenterpolitik",
      "content" => html_parse(File.read(__dir__ + "/seeds/info/studenterpolitik.md"), "markdown")
    },
    {
      "title" => "Ruskorpset",
      "content" => html_parse(File.read(__dir__ + "/seeds/info/ruskorpset.md"), "markdown")
    },
    {
      "title" => "Samarbejdspartnere",
      "content" => html_parse(File.read(__dir__ + "/seeds/info/samarbejdspartnere.md"), "markdown")
    }
  ]
  info_page.save

  howto_page = Page.create(slug: "howto", educational_domain: datswdomain, title: 'Guides', content_header: '<h4>Guides til alt!</h4>', view_file:"accordion")
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

  contacts_page = Page.create(slug: "kontakter", educational_domain: datswdomain, title: 'Kontakt', content_header: '<h4>Her er alle de mennesker der er vigtige!</h4>', content:'mouseover(tap) for kontakt information.', view_file:"contacts")

  advice_page = Page.create(slug: "advice", educational_domain: datswdomain, title: 'Gode råd', content: File.read(__dir__ + "/seeds/advice.html"), content_header: "<h4>Herunder har vi samlet er par gode råd fra ældre studerende på datalogi og software</h4>", view_file:"show")

  ev1datsw = Event.create(title: "Ruskorps Event", educational_domain: datswdomain, description: "<h5>Ruskorpset</h5>Holder et svedigt event!", location: "CS!", lat: 57.0123924, lng: 9.991556199999991, begin_at: "2018-07-16 14:30:00")
  ev2datsw = Event.create(title: "PROSA Event", educational_domain: datswdomain, description: "Noget prosa arrangerer", location: "CS!", lat: 57.0123924, lng: 9.991556199999991, begin_at: "2018-05-18 14:30:00")
  ev3datsw = Event.create(title: "IDA Event", educational_domain: datswdomain, description: "Noget ida arrangerer", location: "CS!", lat: 57.0123924, lng: 9.991556199999991, begin_at: "2018-08-20 14:30:00")
  ev4datsw = Event.create(title: "Studentersamfundet Event", educational_domain: datswdomain, description: "Noget studentersamfundet arrangerer", location: "CS!", lat: 57.0123924, lng: 9.991556199999991, begin_at: "2018-05-22 14:30:00")
  ev4datsw = Event.create(title: "Ruskorps Event2", educational_domain: datswdomain, description: "PUBCRAAAAAWL!", location: "CS!", lat: 57.0123924, lng: 9.991556199999991, begin_at: "2018-06-23 14:30:00")
  ev4datsw = Event.create(title: "Ruskorps Event3", educational_domain: datswdomain, description: "Ruskorpset holder fedt LAN!", location: "CS!", lat: 57.0123924, lng: 9.991556199999991, begin_at: "2018-08-06 14:30:00")

  datswdomain.update(primary_menu: datswmenu, default_page: pa)


end

def create_frontpage(domain)
  dom = EducationalDomain.find_or_initialize_by(domain: domain)
  dom.colors = {"primary-color" => "#211A52"}
  dom.name = 'Rusling.dk'
  dom.locale = 'da'
  dom.save!

  fppage = Page.create!(educational_domain: dom, title: 'rusling.dk', content_header:'Velkommen til rusling.dk', content: 'Find din uddannelse i oversigten nedenunder!', view_file: "frontpage")
  dom.update!(default_page: fppage)
end


def create_engdomain(domain)
  engdomain = EducationalDomain.find_or_initialize_by(domain: domain)
  engdomain.name = 'Engeneering'
  engdomain.educations = ["Matematik", "Fysik", "Matematik-Økonomi", "Noget andet"]
  engdomain.colors = {"primary-color" => "#6EA516", "secondary-color" => "#8BB745"}
  engdomain.locale = "da"
  engdomain.save

  meneng = engdomain.menus.find_or_initialize_by(name: "Eng Menu")
  meneng.items = [
      {
        "name" => "FAQ",
        "description" => "",
        "link" => "/faq",
        "image_url" => 'http://placekitten.com/200/200'
      },
      {
        "name" => "How To",
        "description" => "",
        "link" => "/howto",
        "image_url" => 'http://placekitten.com/300/300'
      },
      {
        "name" => "Arrangementer",
        "description" => "",
        "link" => "/events",
        "image_url" => 'http://placekitten.com/1920/1080'
      },
      {
        "name" => "Information",
        "description" => "",
        "link" => "/info",
        "image_url" => 'http://placekitten.com/500/500'
      },
      {
        "name" => "Vigtige Kontakter",
        "description" => "",
        "link" => "/kontakter",
        "image_url" => 'http://placekitten.com/600/600'
      },
      {
        "name" => "Gode Råd",
        "description" => "",
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
      "content" => html_parse(File.read(__dir__ + "/seeds/info/studiestartsdagen.md"), "markdown")
    },
    #{
    #  "title" => "Studieordninger",
    #  "content" => File.read(__dir__ + "/seeds/info/studieordninger.html")
    #},
    {
      "title" => "Studenterpolitik",
      "content" => html_parse(File.read(__dir__ + "/seeds/info/studenterpolitik.md"), "markdown")
    }#,
    #{
    #  "title" => "Ruskorpset",
    #  "content" => html_parse(File.read(__dir__ + "/seeds/info/ruskorpset.md"), "markdown")
    #},
    #{
    #  "title" => "Samarbejdspartnere",
    #  "content" => html_parse(File.read(__dir__ + "/seeds/info/samarbejdspartnere.md"), "markdown")
    #}
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

  ev1eng = Event.create(title: "Ruskorps Event", educational_domain: engdomain, description: "<h5>Ruskorpset</h5>Holder et svedigt event!", location: "CS!", lat: 57.0123924, lng: 9.991556199999991, begin_at: "2018-05-16 14:30:00")
  ev2eng = Event.create(title: "PROSA Event", educational_domain: engdomain, description: "Noget prosa arrangerer", location: "CS!", lat: 57.0123924, lng: 9.991556199999991, begin_at: "2018-05-18 14:30:00")
  ev3eng = Event.create(title: "IDA Event", educational_domain: engdomain, description: "Noget ida arrangerer", location: "CS!", lat: 57.0123924, lng: 9.991556199999991, begin_at: "2018-05-20 14:30:00")
  ev4eng = Event.create(title: "Studentersamfundet Event", educational_domain: engdomain, description: "Noget studentersamfundet arrangerer", location: "CS!", lat: 57.0123924, lng: 9.991556199999991, begin_at: "2018-05-22 14:30:00")


  engdomain.update(primary_menu: meneng, default_page: paeng)


end

def create_humdomain(domain)
  humdomain = EducationalDomain.find_or_initialize_by(domain: domain)
  humdomain.name = 'Humaniora'
  humdomain.educations = ["Dansk", "Engelsk", "Tysk", "Svensk", "Norsk", "Historie"]
  humdomain.colors = {"primary-color" => "#D20D44", "secondary-color" => "#DB3D69"}
  humdomain.locale = "en"
  humdomain.save

  menhum = humdomain.menus.find_or_initialize_by(name: "Hum Menu")
  menhum.items = [
      {
        "name" => "FAQ",
        "description" => "",
        "link" => "/faq",
        "image_url" => 'http://placekitten.com/200/200'
      },
      {
        "name" => "How To",
        "description" => "",
        "link" => "/howto",
        "image_url" => 'http://placekitten.com/300/300'
      },
      {
        "name" => "Arrangementer",
        "description" => "",
        "link" => "/events",
        "image_url" => 'http://placekitten.com/1920/1080'
      },
      {
        "name" => "Information",
        "description" => "",
        "link" => "/info",
        "image_url" => 'http://placekitten.com/500/500'
      },
      {
        "name" => "Vigtige Kontakter",
        "description" => "",
        "link" => "/kontakter",
        "image_url" => 'http://placekitten.com/600/600'
      },
      {
        "name" => "Gode Råd",
        "description" => "",
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
      "content" => html_parse(File.read(__dir__ + "/seeds/info/studiestartsdagen.md"), "markdown")
    },
    #{
    #  "title" => "Studieordninger",
    #  "content" => File.read(__dir__ + "/seeds/info/studieordninger.html")
    #},
    {
      "title" => "Studenterpolitik",
      "content" => html_parse(File.read(__dir__ + "/seeds/info/studenterpolitik.md"), "markdown")
    }#,
    #{
    #  "title" => "Ruskorpset",
    #  "content" => html_parse(File.read(__dir__ + "/seeds/info/ruskorpset.md"), "markdown")
    #},
    #{
    #  "title" => "Samarbejdspartnere",
    #  "content" => html_parse(File.read(__dir__ + "/seeds/info/samarbejdspartnere.md"), "markdown")
    #}
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

  advicehum_page = Page.create(slug: "advice", educational_domain: humdomain, title: 'Gode råd fra ældre studerende!', content: File.read(__dir__ + "/seeds/advice.html"), view_file:"show")


  ev1hum = Event.create(title: "Ruskorps Event", educational_domain: humdomain, description: "<h5>Ruskorpset</h5>Holder et svedigt event!", location: "CS!", lat: 57.0123924, lng: 9.991556199999991, begin_at: "2018-05-16 14:30:00")
  ev2hum = Event.create(title: "PROSA Event", educational_domain: humdomain, description: "Noget prosa arrangerer", location: "CS!", lat: 57.0123924, lng: 9.991556199999991, begin_at: "2018-05-18 14:30:00")
  ev3hum = Event.create(title: "IDA Event", educational_domain: humdomain, description: "Noget ida arrangerer", location: "CS!", lat: 57.0123924, lng: 9.991556199999991, begin_at: "2018-05-20 14:30:00")
  ev4hum = Event.create(title: "Studentersamfundet Event", educational_domain: humdomain, description: "Noget studentersamfundet arrangerer", location: "CS!", lat: 57.0123924, lng: 9.991556199999991, begin_at: "2018-05-22 14:30:00")

  humdomain.update(primary_menu: menhum ,default_page: fphum_page)


end

def create_samfdomain(domain)
  samfdomain = EducationalDomain.find_or_initialize_by(domain: domain)
  samfdomain.name = 'Samfundsvidenskab'
  samfdomain.educations = ["Kommunikation", "Uddannelse2", "Uddannelse3", "Uddannelse4"]
  samfdomain.colors = {"primary-color" => "#002930", "secondary-color" => "#334561"}
  samfdomain.locale = "da"
  samfdomain.save


  mensamf = samfdomain.menus.find_or_initialize_by(name: "Samf Menu")

  mensamf.items = [
      {
        "name" => "Vigtig Viden",
        "description" => "(FAQ)",
        "link" => "/faq",
        "image_url" => 'http://placekitten.com/200/200'
      },
      {
        "name" => "Information",
        "description" => "Alt om studiestartsdagen osv.",
        "link" => "/info",
        "image_url" => 'http://placekitten.com/500/500'
      },
      {
        "name" => "Arrangementer",
        "description" => "Se kalenderen over de kommende arrangementer",
        "link" => "/events",
        "image_url" => 'http://placekitten.com/1920/1080'
      },
      {
        "name" => "Kontakt",
        "description" => "Få overblik over hvem du kan kontakte",
        "link" => "/kontakter",
        "image_url" => 'http://placekitten.com/600/600'
      },
      {
        "name" => "Guides",
        "description" => "Hjælp til print, Wifi osv.",
        "link" => "/howto",
        "image_url" => 'http://placekitten.com/300/300'
      },
      {
        "name" => "Gode Råd",
        "description" => "Kloge ord fra andre studerende",
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
      "content" => html_parse(File.read(__dir__ + "/seeds/info/studiestartsdagen.md"), "markdown")
    },
    #{
    #  "title" => "Studieordninger",
    #  "content" => File.read(__dir__ + "/seeds/info/studieordninger.html")
    #},
    {
      "title" => "Studenterpolitik",
      "content" => html_parse(File.read(__dir__ + "/seeds/info/studenterpolitik.md"), "markdown")
    }#,
    #{
    #  "title" => "Ruskorpset",
    #  "content" => html_parse(File.read(__dir__ + "/seeds/info/ruskorpset.md"), "markdown")
    #},
    #{
    #  "title" => "Samarbejdspartnere",
    #  "content" => html_parse(File.read(__dir__ + "/seeds/info/samarbejdspartnere.md"), "markdown")
    #}
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

  ev1samf = Event.create(title: "Ruskorps Event", educational_domain: samfdomain, description: "<h5>Ruskorpset</h5>Holder et svedigt event!", location: "CS!", lat: 57.0123924, lng: 9.991556199999991, begin_at: "2018-05-16 14:30:00")
  ev2samf = Event.create(title: "PROSA Event", educational_domain: samfdomain, description: "Noget prosa arrangerer", location: "CS!", lat: 57.0123924, lng: 9.991556199999991, begin_at: "2018-05-18 14:30:00")
  ev3samf = Event.create(title: "IDA Event", educational_domain: samfdomain, description: "Noget ida arrangerer", location: "CS!", lat: 57.0123924, lng: 9.991556199999991, begin_at: "2018-05-20 14:30:00")
  ev4samf = Event.create(title: "Studentersamfundet Event", educational_domain: samfdomain, description: "Noget studentersamfundet arrangerer", location: "CS!", lat: 57.0123924, lng: 9.991556199999991, begin_at: "2018-05-22 14:30:00")


  samfdomain.update(primary_menu: mensamf, default_page: pasamf)


end

def create_sunddomain(domain)
  sunddomain = EducationalDomain.find_or_initialize_by(domain: domain)
  sunddomain.name = 'Sund'
  sunddomain.educations = ["Idræt", "Medicin", "MEDIS", "Uddannelse42", "Uddannelse43"]
  sunddomain.colors = {"primary-color" => "#FFCC00", "secondary-color" => "#FFD636"}
  sunddomain.locale = "en"
  sunddomain.save


  mensund = sunddomain.menus.find_or_initialize_by(name: "Sund Menu")

  mensund.items = [
      {
        "name" => "FAQ",
        "description" => "",
        "link" => "/faq",
        "image_url" => 'http://placekitten.com/200/200'
      },
      {
        "name" => "How To",
        "description" => "",
        "link" => "/howto",
        "image_url" => 'http://placekitten.com/300/300'
      },
      {
        "name" => "Arrangementer",
        "description" => "",
        "link" => "/events",
        "image_url" => 'http://placekitten.com/1920/1080'
      },
      {
        "name" => "Information",
        "description" => "",
        "link" => "/info",
        "image_url" => 'http://placekitten.com/500/500'
      },
      {
        "name" => "Vigtige Kontakter",
        "description" => "",
        "link" => "/kontakter",
        "image_url" => 'http://placekitten.com/600/600'
      },
      {
        "name" => "Gode Råd",
        "description" => "",
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
      "content" => html_parse(File.read(__dir__ + "/seeds/info/studiestartsdagen.md"), "markdown")
    },
    #{
    #  "title" => "Studieordninger",
    #  "content" => File.read(__dir__ + "/seeds/info/studieordninger.html")
    #},
    {
      "title" => "Studenterpolitik",
      "content" => html_parse(File.read(__dir__ + "/seeds/info/studenterpolitik.md"), "markdown")
    }#,
    #{
    #  "title" => "Ruskorpset",
    #  "content" => html_parse(File.read(__dir__ + "/seeds/info/ruskorpset.md"), "markdown")
    #},
    #{
    #  "title" => "Samarbejdspartnere",
    #  "content" => html_parse(File.read(__dir__ + "/seeds/info/samarbejdspartnere.md"), "markdown")
    #}
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

  ev1sund = Event.create(title: "Ruskorps Event", educational_domain: sunddomain, description: "<h5>Ruskorpset</h5>Holder et svedigt event!", location: "CS!", lat: 57.0123924, lng: 9.991556199999991, begin_at: "2018-05-16 14:30:00")
  ev2sund = Event.create(title: "PROSA Event", educational_domain: sunddomain, description: "Noget prosa arrangerer", location: "CS!", lat: 57.0123924, lng: 9.991556199999991, begin_at: "2018-05-18 14:30:00")
  ev3sund = Event.create(title: "IDA Event", educational_domain: sunddomain, description: "Noget ida arrangerer", location: "CS!", lat: 57.0123924, lng: 9.991556199999991, begin_at: "2018-05-20 14:30:00")
  ev4sund = Event.create(title: "Studentersamfundet Event", educational_domain: sunddomain, description: "Noget studentersamfundet arrangerer", location: "CS!", lat: 57.0123924, lng: 9.991556199999991, begin_at: "2018-05-22 14:30:00")


  sunddomain.update(primary_menu: mensund, default_page: pasund)

end



if Rails.env.production?
  #Create Frontpage
  create_frontpage('192.38.56.109')

  #Create domains
  create_datsw('192.38.56.109')



end

if Rails.env.development?
#Forside
  create_frontpage('localhost')

#Domæner
  create_datsw('datsw.localhost')

end