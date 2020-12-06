class Artist < ActiveRecord::Base
  extend Concerns::FindBySlug
  include Concerns::Slugifiable
  has_many :songs
  has_many :genres, through: :songs
end