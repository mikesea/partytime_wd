module Recommender

  def self.recommend_tracks_from_artists(artists)
    tracks = []
    15.times do |n|
      tracks << Track.new(title: "title_#{n+1}", 
        artist_name: "artist_#{n+1}",
        album_title: "album_#{n+1}",
        rdio_id: "t#{n+1}")
    end
    tracks
  end

end