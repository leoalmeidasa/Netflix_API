# frozen_string_literal: true

class CreateNetflixes < ActiveRecord::Migration[6.1]
  def change
    create_table :netflixes do |t|
      t.string :id_csv
      t.string :genre
      t.string :title
      t.string :director
      t.string :cast
      t.string :country
      t.datetime :published_at
      t.integer :year
      t.string :rating
      t.string :duration
      t.string :listed_in
      t.string :description

      t.timestamps
    end
  end
end
