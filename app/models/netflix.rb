# frozen_string_literal: true

class Netflix < ApplicationRecord
  scope :published_at, ->(published_at) { where('published_at > ?', published_at) }
  scope :genre, ->(genre) { where('genre = ?', genre) }
  scope :country, ->(country) { where('country = ?', country) }
end
