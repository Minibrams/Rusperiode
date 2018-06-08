require 'rails_helper'

RSpec.describe Public::PagesController, type: :controller do


  describe 'GET #show' do
    it 'returns http success' do
      page = FactoryBot.create(:page)
      get :show, params: { slug: page.slug }
      expect(response).to have_http_status(:success)
    end
  end



end