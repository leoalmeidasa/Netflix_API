# frozen_string_literal: true

require 'csv'

class NetflixService
  def import(file)
    csv_text = File.read(file)
    csv = CSV.parse(csv_text, headers: true, encoding: 'ISO-8859-1', col_sep: ',')
    csv.each do |row|
      netiflix = ensure_duplicity(row)

      netiflix.genre = row['type']
      netiflix.title = row['title']
      netiflix.director = row['director']
      netiflix.cast = row['cast']
      netiflix.country = row['country']
      netiflix.published_at = row['date_added']
      netiflix.year = row['release_year']
      netiflix.rating = row['rating']
      netiflix.duration = row['duration']
      netiflix.listed_in = row['listed_in']
      netiflix.description = row['description']

      netiflix.save
    end
  end

  def self.ensure_duplicity(row)
    Netflix.find_or_initialize_by(id_csv: row['show_id'])
  end
end
