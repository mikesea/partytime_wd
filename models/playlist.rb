class Playlist < ActiveRecord::Base
  has_many :tracks

  def as_json(*options)
    { id: id, tracks: tracks.map(&:as_json) }
  end

  def self.build_from_artists(artists)
    Playlist.new tracks: Recommender.recommend_tracks_from_artists(artists)
  end
end