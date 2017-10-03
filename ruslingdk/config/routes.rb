Rails.application.routes.draw do

  get 'public/contacts'

  get 'public/calendar'

  get 'events/knoldbold'

  get 'events/pubcrawl'

  get 'events/lan'

  get 'events/ruskursus'

  get 'events/boardgame'

  get 'events/latex'

  get 'how_to/latex'

  get 'how_to/wifi'

  get 'how_to/student_card'

  get 'how_to/printer'

  get 'how_to/schedule'

  get 'how_to/student_mail'

  get 'how_to/moodle'

  get 'faq/index'
  get 'faq/studystart'
  get 'faq/exam'
  get 'faq/study'
  resources :memes, only: [:index, :show]

  root to: 'faq#index'
end
