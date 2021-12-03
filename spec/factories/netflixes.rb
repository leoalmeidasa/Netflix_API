# frozen_string_literal: true

FactoryBot.define do
  factory :netflix do
    id_csv { 's100' }
    genre { 'Anime' }
    title { 'Kimetsu Yaba' }
    director { 'Koyoharu Gotōge' }
    cast { 'Tanjirō Kamado' }
    country { 'Japão' }
    published_at { '2019-09-28' }
    year { '2019' }
    rating { '9' }
    duration { '2 seasons' }
    listed_in { 'Aventura, Fantasia, Artes Marciais' }
    description do
      ' uma série japonesa de mangá shōnen escrita e ilustrada por Koyoharu Gotōge. O mangá é serializado desde'
    end
  end
end
