class Netflix < ApplicationRecord
  require 'csv'

  scope :published_at, ->(published_at) { where("published_at > ?", published_at) }
  scope :genre, ->(genre) { where("genre = ?", genre) }
  scope :country, ->(country) { where("country = ?", country) }

  def self.import(file)
    CSV.foreach(file.path, col_sep: ',').with_index do |linha, indice|
      unless (indice == 0)
        Netflix.create!(id_csv: linha[0], genre: linha[1], title: linha[2], director: linha[3], cast: linha[4],
                        country: linha[5], published_at: linha[6], year: linha[7], rating: linha[8],
                        duration: linha[9], listed_in: linha[10], description: linha[11])
      end
    end
  end
end
