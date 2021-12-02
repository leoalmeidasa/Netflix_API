# frozen_string_literal: true

require 'csv'

class NetflixService
  def import(file)
    csv_text = File.read(file)
    csv = CSV.parse(csv_text, headers: true, encoding: 'ISO-8859-1', col_sep: ',')
    csv.each do |row|
      netflix = ensure_duplicity(row)

      netflix.genre = row['type']
      netflix.title = row['title']
      netflix.director = row['director']
      netflix.cast = row['cast']
      netflix.country = row['country']
      netflix.published_at = row['date_added'].to_date
      netflix.year = row['release_year']
      netflix.rating = row['rating']
      netflix.duration = row['duration']
      netflix.listed_in = row['listed_in']
      netflix.description = row['description']

      netflix.save
    end
  end

  def ensure_duplicity(row)
    Netflix.find_or_initialize_by(id_csv: row['show_id'])
  end
end
