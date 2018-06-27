require 'rails_helper'

RSpec.describe Public::PagesController, type: :controller do

  describe 'GET_show' do
    context 'with show view_file' do
      let(:show_page) { create :page, :show, :with_domain }

      it 'returns http success' do
        get :show, params: { slug: show_page.slug }
        expect(response).to have_http_status(:success)
      end
    end
  end
end