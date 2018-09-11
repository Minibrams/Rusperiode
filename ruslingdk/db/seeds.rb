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
  puts "creating datsw"
  datswdomain = EducationalDomain.find_or_initialize_by(domain: domain)
  datswdomain.name = 'Datalogi og Software'
  datswdomain.educations = ["Datalogi", "Software"]
  datswdomain.colors = {"primary-color" => "#eb7115", "secondary-color" => "#f19c5c"}
  datswdomain.locale = "da"
  datswdomain.save

  datswmenu = datswdomain.menus.find_or_initialize_by(name: "DatSW Menu")
  datswmenu.items = [
    {
      "name" => "Vigtig viden",
      "description" => "Ligegyldig info",
      "link" => "/faq",
      "image_url" => 'menu/vigtigviden.png'
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
      "image_url" => 'menu/arrangementer.png'
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
      "image_url" => 'menu/guides.png'
    },
    {
      "name" => "Gode råd",
      "description" => "Kloge ord fra andre studerende",
      "link" => "/advice",
      "image_url" => 'menu/goderaad.png'
    }
    ]
  datswmenu.educational_domain = datswdomain
  datswmenu.save

  puts "creating datsw contacts"
  #Contacts
  tobias = Contact.find_or_initialize_by(educational_domain: datswdomain, name: "Tobias Palludan")
  tobias.email = "tpallu16@student.aau.dk"
  tobias.number = "20 58 21 14"
  tobias.description = "Tobias er ansvarlig for studiestartsperioden. Er du i tvivl om noget, kan du starte med at skrive til Tobias - så finder han den rette person til dig."
  tobias.image = "contacts/tobiaspalludan.jpg"
  tobias.save

  diana = Contact.find_or_initialize_by(educational_domain: datswdomain, name: "Diana Wolff Bie")
  diana.email = "dwb@staff.aau.dk"
  diana.description = "Diana er studiesekretæren, og står for mange af de praktiske ting på jeres uddannelse. I vil høre mere om, hvordan hun kan hjælpe, til studiestarten."
  diana.image = "contacts/dianawolffbie.jpg"
  diana.save

  brams = Contact.find_or_initialize_by(educational_domain: datswdomain, name: "Anders Brams")
  brams.email = "studievejl@cs.aau.dk"
  brams.description = "Anders er tutor og studievejleder, og ham og hans kolleger kan hjælpe med dispensationer, eksamensregler, studiemiljø, og andre emner i den boldgade."
  brams.image = "contacts/andersbrams.jpg"
  brams.save

  kurt = Contact.find_or_initialize_by(educational_domain: datswdomain, name: "Kurt Nørmark")
  kurt.email = "normark@cs.aau.dk"
  kurt.description = "Du kan skrive til Kurt hvis du har spørgsmål vedr. alt der har med studiet, grupper og projekter at gøre."
  kurt.image = "contacts/kurt.jpg"
  kurt.save

  #anders = Contact.create(educational_domain: datswdomain, name: "Anders Madsen", email: "amads15@student.aau.dk", number: "31 61 79 58", description: "Anders er toxic af!", image: "http://placekitten.com/1200/500")

  puts "creating datsw sponsors"
  #Sponsors
  sponsor_progras = Sponsor.find_or_initialize_by(educational_domain: datswdomain, name: "progras")
  sponsor_progras.image = "sponsors/progras.png"
  sponsor_progras.save

  sponsor_prosa = Sponsor.find_or_initialize_by(educational_domain: datswdomain, name: "prosa")
  sponsor_prosa.image = "sponsors/prosa.png"
  sponsor_prosa.save

  sponsor_cego = Sponsor.find_or_initialize_by(educational_domain: datswdomain, name: "cego")
  sponsor_cego.image = "sponsors/cego.png"
  sponsor_cego.save

  sponsor_bankdata = Sponsor.find_or_initialize_by(educational_domain: datswdomain, name: "bankdata")
  sponsor_bankdata.image = "sponsors/bankdata.png"
  sponsor_bankdata.save

  sponsor_accenture = Sponsor.find_or_initialize_by(educational_domain: datswdomain, name: "accenture")
  sponsor_accenture.image = "sponsors/accenture.png"
  sponsor_accenture.save

  pa = Page.find_or_initialize_by(educational_domain: datswdomain, title: 'Datalogi og Software')
  pa.content_header = 'Velkommen til Rusling.dk'
  pa.content = 'Vi gør alt hvad vi kan for at I kan få en fantastisk start på jeres studie! Her på siden har vi forsøgt at samle alle de informationer I kunne få brug for!<br><em>&ndash; Tutorerne</em>'
  pa.view_file =  "index"
  pa.save

  faq_page = Page.find_or_initialize_by(slug: "faq", educational_domain: datswdomain)
  faq_page.title = 'Vigtig viden (FAQ)'
  faq_page.content_header = 'Her er svarene på alle jeres spørgmål!'
  faq_page.view_file = "accordion"
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

  info_page = Page.find_or_initialize_by(slug: "info", educational_domain: datswdomain)
  info_page.title = 'Information'
  info_page.content_header = 'Vi har samlet så mange informationer som mulig!'
  info_page.content = 'Hvis I synes der mangler noget, må I gerne sige til!'
  info_page.view_file = "accordion"
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

  howto_page = Page.find_or_initialize_by(slug: "howto", educational_domain: datswdomain)
  howto_page.title = 'Guides'
  howto_page.content_header = 'Guides til alt!'
  howto_page.view_file = "accordion"
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

  contacts_page = Page.find_or_initialize_by(slug: "kontakter", educational_domain: datswdomain)
  contacts_page.title = 'Kontakt'
  contacts_page.content_header = 'Her er alle de mennesker der er vigtige!'
  contacts_page.content = 'mouseover(tap) for kontakt information.'
  contacts_page.view_file = "contacts"
  contacts_page.save

  advice_page = Page.find_or_initialize_by(slug: "advice", educational_domain: datswdomain)
  advice_page.title = 'Gode råd'
  advice_page.content = File.read(__dir__ + "/seeds/advice.html")
  advice_page.content_header = "Herunder har vi samlet er par gode råd fra ældre studerende på datalogi og software"
  advice_page.view_file = "show"
  advice_page.save

  puts "creating datsw events"

  studiestartsdag = Event.find_or_initialize_by(title: "Studiestartsdagen", educational_domain: datswdomain)
  studiestartsdag.description = "<h5>Klar, parat, studiestart!</h5><p>Vi glæder os utrolig meget til at tage imod jer!<br />Mere info om dagen kan I finde <a href=\"/info/\">her</a> under overskriften \"Studiestartsdagen\"</p>"
  studiestartsdag.location = "Honnørkajen"
  studiestartsdag.lat = 57.0502987
  studiestartsdag.lng = 9.9229435
  studiestartsdag.begin_at = "2018-09-03 08:30:00"
  studiestartsdag.save

  pubcrawl = Event.find_or_initialize_by(title: "Pubcrawl", educational_domain: datswdomain)
  pubcrawl.description = "Pubcrawl er en sjov og hyggelig aften, hvor I kommer rundt på de forskellige barer i Aalborg. I vil i starten af aftenen blive delt ind i hold, og dyste imod andre hold I møder. Dommerne på stedet vil tildele og fratage points fra de forskellige hold, og aftenens vinder vil modtage en velfortjent præmie, når I alle sammen samles til sidst i byen.
  Bemærk, at der ikke er nogen af legene, hvor der er nødvendigt at drikke for at deltage."
  pubcrawl.location = "Honnørkajen"
  pubcrawl.lat = 57.048134
  pubcrawl.lng = 9.919349
  pubcrawl.begin_at = "2018-09-12 18:00:00"
  pubcrawl.save

  boardgame = Event.find_or_initialize_by(title: "Brætspilsaften", educational_domain: datswdomain)
  boardgame.description = "Prosa inviterer jer til brætspilsaften, hvor I har mulighed for at hygge jer med nogle af jeres tutorer og medstuderende. Prosa har booket cafeen til os, og giver derudover den første omgang. Så tag dine gruppemedlemmer under armen, og kom til en hyggelig aften!"
  boardgame.location = "Dice'n'Drinks"
  boardgame.lat = 57.0465307
  boardgame.lng = 9.9165076
  boardgame.begin_at = "2018-09-17 16:30:00"
  boardgame.save

  knoldbold = Event.find_or_initialize_by(title: "Knoldbold", educational_domain: datswdomain)
  knoldbold.description = "Knoldbold er den ædle og oldgamle disciplin i organiseret kaos. Med 4 hold på banen, som kæmper to forskellige kampe, og korrupte, unfair dommere, er det helt garanteret, at der ikke er nogen der forstår hvad der foregår. Det skal nok blive sjovt!
  Der er mindst 4 på banen fra hvert hold, og I skal derfor lave en gruppe med udklædningstema og bold. Der vil være præmier til vinderen af Knoldbold, og præmier til den bedste udklædning."
  knoldbold.location = "Fjordmarken"
  knoldbold.lat = 57.055934
  knoldbold.lng = 9.906076
  knoldbold.begin_at = "2018-09-20 14:30:00"
  knoldbold.save

  ruskursus = Event.find_or_initialize_by(title: "Ruskursus", educational_domain: datswdomain)
  ruskursus.description = "Ruskursus er studiestartsperiodens absolutte højdepunkt. Vi tager tidligt afsted onsdag morgen, og vil i løbet af onsdagen og torsdagen gennemgå en blanding af hyggelige, sociale aktiviteter, og spændende faglige arrangementer. Torsdag aften afsluttes med en kæmpe fest, hvor vi blandt andet spiser fantastisk mad, laver sketches i vores grupper, og har en fed aften, hvor vi lærer hinanden at kende, inden vi fredag morgen tager hjem til Aalborg igen."
  ruskursus.location = "Kvickly Vestbyen"
  ruskursus.lat = 57.054528
  ruskursus.lng = 9.906408
  ruskursus.begin_at = "2018-10-03 08:30:00"
  ruskursus.save

  latex = Event.find_or_initialize_by(title: "LaTeX kursus", educational_domain: datswdomain)
  latex.description = "PROSA inviterer på gratis LaTeX kursus! Kun for jer! Fordi I er nice!"
  latex.location = "AUD 7"
  latex.lat = 57.053007
  latex.lng = 9.912546
  latex.begin_at = "2018-10-11 16:30:00"
  latex.save

  ruslan = Event.find_or_initialize_by(title: "Ruslan", educational_domain: datswdomain)
  ruslan.description = "RusLAN er et alkoholfrit arrangement, hvor der bliver dystet i diverse anerkendte e-sportsgrene. I løbet af en hel weekend vil der blive råbt \"n00b\" og \"360n0sc0pe\" i stride strømme, når der bliver afholdt turneringer i CSGO, Rocket League, LoL/DoTa, og 2 andre turneringer - selvfølgelig alt sammen med mega fede præmier!
  Fik vi nævnt, at vi giver pizza både fredag og lørdag?"
  ruslan.location = "Cassiopeia"
  ruslan.lat = 57.0123062
  ruslan.lng = 9.9889782
  ruslan.begin_at = "2018-10-19 17:30:00"
  ruslan.save

  datswdomain.update(primary_menu: datswmenu, default_page: pa)


end

def create_frontpage(domain)
  dom = EducationalDomain.find_or_initialize_by(domain: domain)
  dom.colors = {"primary-color" => "#211A52"}
  dom.name = 'Rusling.dk'
  dom.locale = 'da'
  dom.save!

  fppage = Page.create!(educational_domain: dom, title: 'rusling.dk', content_header: 'Velkommen til rusling.dk', content: 'Find din uddannelse i oversigten nedenunder!', view_file: "frontpage")
  dom.update!(default_page: fppage)
end


def create_engdomain(domain)
  engdomain = EducationalDomain.find_or_initialize_by(domain: domain)
  engdomain.name = 'Engeneering'
  engdomain.educations = ["Matematik", "Fysik", "Matematik-Økonomi", "Noget andet"]
  engdomain.colors = {"primary-color" => "#4d9e45", "secondary-color" => "#83bb7d"}
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
  humdomain.colors = {"primary-color" => "#CD563F", "secondary-color" => "#dc8979"}
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
  samfdomain.colors = {"primary-color" => "#1a2633", "secondary-color" => "#5f6871"}
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
  sunddomain.colors = {"primary-color" => "#edc131", "secondary-color" => "#f2d46f"}
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

def create_baitixdinf(domain)
  puts "creating baitixdinf domain"
  baitixdinfdomain = EducationalDomain.find_or_initialize_by(domain: domain)
  baitixdinfdomain.name = 'Informationsteknologi, Interaktionsdesign og Informatik'
  baitixdinfdomain.educations = ["Informationsteknologi", "Interaktionsdesign", "Informatik"]
  baitixdinfdomain.colors = {"primary-color" => "#eb7115", "secondary-color" => "#f19c5c"}
  baitixdinfdomain.locale = "da"
  baitixdinfdomain.save

  baitixdinfmenu = baitixdinfdomain.menus.find_or_initialize_by(name: "BaitIxdInf Menu")
  baitixdinfmenu.items = [
    {
      "name" => "Information",
      "description" => "Studiestartsdagen og andet",
      "link" => "/information",
      "image_url" => 'menu/vigtigviden.png'
    },
    {
      "name" => "Arrangementer",
      "description" => "Begivenheder i studiestartsperioden",
      "link" => "/events",
      "image_url" => ''
    },
    {
      "name" => "Kontakt",
      "description" => "Hvem kan du kontakte?",
      "link" => "/kontakter",
      "image_url" => 'menu/arrangementer.png'
    },
    {
      "name" => "Guides",
      "description" => "Print, WiFi og andet",
      "link" => "/guides",
      "image_url" => ''
    },
    ]
  baitixdinfmenu.educational_domain = baitixdinfdomain
  baitixdinfmenu.save

  #Contacts
  contact1 = Contact.find_or_initialize_by(educational_domain: baitixdinfdomain, name: "Anders Høgh")
  contact1.email = "ahha15@student.aau.dk"
  contact1.number = "31 31 78 28"
  contact1.description = "Anders er jeres overinstruktør. Det er ham som har det overordnede ansvar for jeres studiestartsperiode. Er du i tvivl om noget så kontakt ham gerne!"
  contact1.image = "contacts/andershogh.jpg"
  contact1.save

  contact2 = Contact.find_or_initialize_by(educational_domain: baitixdinfdomain, name: "Studiesekretær")
  contact2.description = "Kontaktinformationer kommer"
  contact2.image = "contacts/placeholder.jpg"
  contact2.save

  contact3 = Contact.find_or_initialize_by(educational_domain: baitixdinfdomain, name: "Anders Brams")
  contact3.email = "studievejl@cs.aau.dk"
  contact3.description = "Anders er tutor og studievejleder, og ham og hans kolleger kan hjælpe med dispensationer, eksamensregler, studiemiljø, og andre emner i den boldgade."
  contact3.image = "contacts/andersbrams.jpg"
  contact3.save

  contact4 = Contact.find_or_initialize_by(educational_domain: baitixdinfdomain, name: "Pernille Aagaard Madsen")
  contact4.email = "pama16@student.aau.dk"
  contact4.description = "Pernille er én af de 4 tutorinstruktører tilknytte din studiestart. Pernille læser Informatik på 5. semester, og kan svare på diverse spørgsmål ang. uddannelserne BaIT/ INF. "
  contact4.image = "contacts/placeholder.jpg"
  contact4.save


  #Sponsors
  sponsor1 = Sponsor.find_or_initialize_by(educational_domain: baitixdinfdomain, name: "prosa")
  sponsor1.image = "sponsors/prosa.png"
  sponsor1.save


  pa_baitixdinf = Page.find_or_initialize_by(educational_domain: baitixdinfdomain, title: 'Informationsteknologi, Interaktionsdesign og Informatik')
  pa_baitixdinf.content_header = 'Velkommen til Rusling.dk'
  pa_baitixdinf.content = 'Vi gør alt hvad vi kan for at I kan få en fantastisk start på jeres studie! Her på siden har vi forsøgt at samle alle de informationer I kunne få brug for!<br><em>&ndash; Tutorerne</em>'
  pa_baitixdinf.view_file = "index"
  pa_baitixdinf.save

  faq_page = Page.find_or_initialize_by(slug: "information", educational_domain: baitixdinfdomain)
  faq_page.title = 'Information'
  faq_page.content_header = 'Alt (..næsten) der er værd at vide om studiestarten!'
  faq_page.content = 'Mangler der noget du vil vide? Skriv til ahha15@student.aau.dk med spørgsmålet'
  faq_page.view_file = "accordion"
  faq_page.accordion = [
    {
      "title" => "Studiestartsdagen",
      "content" => html_parse(File.read(__dir__ + "/seeds/baitixdinf/information/studiestartsdagen.md"), "markdown")
    },
    {
      "title" => "Ruskorpset",
      "content" => html_parse(File.read(__dir__ + "/seeds/baitixdinf/information/ruskorpset.md"), "markdown")
    },
    {
      "title" => "Samarbejdspartnere",
      "content" => html_parse(File.read(__dir__ + "/seeds/baitixdinf/information/samarbejdspartnere.md"), "markdown")
    },
    {
      "title" => "Rusturen",
      "content" => html_parse(File.read(__dir__ + "/seeds/baitixdinf/information/rusturen.md"), "markdown")
    }
  ]
  faq_page.save

  howto_page = Page.find_or_initialize_by(slug: "guides", educational_domain: baitixdinfdomain)
  howto_page.title = 'Guides'
  howto_page.content_header = 'Guides til alt!'
  howto_page.view_file = "accordion"
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
    },
    {
      "title" => "InDesign",
      "content" => html_parse(File.read(__dir__ + "/seeds/baitixdinf/guides/indesign.md"), "markdown")
    }
  ]
  howto_page.save

  contacts_page = Page.find_or_initialize_by(slug: "kontakter", educational_domain: baitixdinfdomain)
  contacts_page.title = 'Kontakt'
  contacts_page.content_header = 'Hvem skal du have fat i for at få svar på dit spørgsmål?'
  contacts_page.content = 'Hold musen over billedet for at se kontaktoplysninger på personen!'
  contacts_page.view_file = "contacts"
  contacts_page.save

  ev1baitixdinf = Event.find_or_initialize_by(title: "Studiestartsdag", educational_domain: baitixdinfdomain)
  ev1baitixdinf.description = "<p>Den store dag! Du starter på dit studie. Husk at vi mødes på Honnørkajen. Se kortet hvis du er i tvivl om hvor det er.</p>"
  ev1baitixdinf.location = "Honnørkajen"
  ev1baitixdinf.lat = 57.0502987
  ev1baitixdinf.lng = 9.9229435
  ev1baitixdinf.begin_at = "2018-09-03 08:30:00"
  ev1baitixdinf.save

  baitixdinfdomain.update(primary_menu: baitixdinfmenu, default_page: pa_baitixdinf)


end

if Rails.env.production?
  #Create Frontpage
  #create_frontpage('rusling.dk')

  #Create domains
  create_datsw('datsw.rusling.dk')
  create_baitixdinf('bait-ixd-inf.rusling.dk')
end

if Rails.env.development?
#Forside
  create_frontpage('localhost')

#Domæner
  create_baitixdinf('bait-ixd-inf.localhost')
  create_datsw('datsw.localhost')

end