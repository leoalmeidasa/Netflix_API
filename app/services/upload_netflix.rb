class UploadNetflix
  require 'csv'

  def self.import(file)
    csv_text = File.read(file.path)
    csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1', col_sep: ',')
      csv.each do |row|
        n = Netflix.new
        n.id_csv = row['show_id']
        n.genre  = row['type']
        n.title = row['title']
        n.director = row['director']
        n.cast = row['cast']
        n.country = row['country']
        n.published_at = row['date_added']
        n.year = row['release_year']
        n.rating = row['rating']
        n.duration = row['duration']
        n.listed_in = row['listed_in']
        n.description = row['description']
        n.save

        puts "#{n.id_csv}, #{n.genre}, #{n.title}, #{n.director}, #{n.cast}, #{n.country},#{n.published_at},
        #{n.year}, #{n.rating}, #{n.duration}, #{n.listed_in} saved"
      end
  end
end