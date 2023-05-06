require 'rails_helper'

RSpec.describe UrlsController, type: :controller do
  describe 'GET #index' do
    it 'renders the :index template' do
      get :index
      expect(response).to render_template :index
    end

    context 'when there are urls' do
      let!(:urls) { create_list(:url, 3) }

      it 'returns all urls' do
        get :index
        expect(assigns(:urls)).to match_array(urls)
      end
    end

    context 'when there are no urls' do
      it 'returns an empty array' do
        get :index
        expect(assigns(:urls)).to eq([])
      end
    end
  end

  describe 'POST #create' do
    let(:params) do
      {
        url: {
          original: 'www.google.com'
        }
      }
    end

    subject { post :create, params: }

    context 'with valid attributes' do
      it 'creates a new url' do
        expect { subject }.to change(Url, :count).by(1)
      end
    end

    context 'when original param is blank' do
      it 'does not create a new url' do
        params[:url][:original] = ''

        expect { subject }.to_not change(Url, :count)
      end
    end

    context 'when original param is not a valid url' do
      it 'does not create a new url' do
        params[:url][:original] = 'not a url'

        expect { subject }.to_not change(Url, :count)
      end
    end
  end

  describe 'GET #show' do
    let!(:url) { create(:url) }

    it 'assigns the requested url to @url' do
      get :show, params: { id: url.id }
      expect(assigns(:url)).to eq(url)
    end

    it 'renders the :show template' do
      get :show, params: { id: url.id }
      expect(response).to render_template :show
    end
  end
end
