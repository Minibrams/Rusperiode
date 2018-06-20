require 'rails_helper'

RSpec.describe Public::PagesController, type: :controller do

  describe 'GET_show' do

    let(:accrordion_page) { create :page, :accordion, :with_domain }
    let(:contacts_page) { create :page, :contacts, :with_domain }
    let(:frontpage_page) { create :page, :frontpage, :with_domain }
    let(:index_page) { create :page, :index, :with_domain }
    let(:show_page) { create :page, :show, :with_domain }

    context 'with accordion view_file' do
      it 'returns http success' do
        get :show, params: { slug: accrordion_page.slug }
        expect(response).to have_http_status(:success)
      end
    end

    context 'with contacts view_file' do
      it 'returns http success' do
        get :show, params: { slug: contacts_page.slug }
        expect(response).to have_http_status(:success)
      end
    end

    context 'with frontpage view_file' do
      it 'returns http success' do
        get :show, params: { slug: frontpage_page.slug }
        expect(response).to have_http_status(:success)
      end
    end

    context 'with index view_file' do
      it 'returns http success' do
        get :show, params: { slug: index_page.slug }
        expect(response).to have_http_status(:success)
      end
    end

    context 'with show view_file' do
      it 'returns http success' do
        get :show, params: { slug: show_page.slug }
        expect(response).to have_http_status(:success)
      end
    end
  end
end