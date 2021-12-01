# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Netflixes', type: :request do
  let(:netflix) { create(:netflix) }
  let(:netflix_valid_attributes) { build(:netflix).attributes }

  let(:invalid_attributes) do
    {
      genre: 'Anime',
      title: nil,
      director: 'Koyoharu Gotōge',
      cast: 'Tanjirō Kamado',
      country: 'Japão',
      published_at: '2019-09-28',
      year: nil,
      rating: '9',
      duration: '2 seasons',
      listed_in: 'Aventura, Fantasia, Artes Marciais',
      description: nil
    }
  end

  let(:valid_headers) do
    {}
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Netflix.create! netflix_valid_attributes
      get api_v1_netflixes_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end

    it 'render country filter' do
      get "/api/v1/netflixes?country=Brazil", as: :json
      expect(response).to be_successful
    end

    it 'render genre filter' do
      get "/api/v1/netflixes?genre=TV Show", as: :json
      expect(response).to be_successful
    end

    it 'render published_at filter' do
      get "/api/v1/netflixes?published_at=2021-01-01", as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get api_v1_netflix_url(netflix), as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Netflix' do
        expect do
          post api_v1_netflixes_url,
               params: { netflix: netflix_valid_attributes }, as: :json
        end.to change(Netflix, :count).by(1)
      end

      it 'renders a JSON response with the new netflix' do
        post api_v1_netflixes_url,
             params: { netflix: netflix_valid_attributes }, as: :json
        expect(response).to have_http_status(:created)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested netflix' do
      netflix = Netflix.create! netflix_valid_attributes
      expect do
        delete api_v1_netflix_url(netflix), as: :json
      end.to change(Netflix, :count).by(-1)
    end
  end
end
