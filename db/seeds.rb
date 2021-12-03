# frozen_string_literal: true

require 'csv'

csv_file = Rails.root.join('lib', 'seeds', 'netflix_titles.csv')
NetflixService.new.import(csv_file)
