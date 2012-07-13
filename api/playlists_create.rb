describe_service "playlists" do |service|
  service.formats   :json
  service.http_verb :post
  service.disable_auth # on by default
  
  # INPUT
  service.params do |p|
    p.array :artists do |artist|
      artist.string :artist_name,
                    :doc => "The name of an artist used to recommend tracks for the playlist"
    end
  end
  
  # OUTPUT
  service.response do |response|
    response.object do |playlist|
      playlist.integer :id
      playlist.array :tracks do |track|
        track.string :title
        track.string :album_title
        track.string :artist_name
        track.string :rdio_id
      end
    end
  end
  
  # DOCUMENTATION
  service.documentation do |doc|
    doc.overall "This service generates a 15-song playlist, taking up to 5 artists to recommend tracks from."
    doc.example "<code>curl -d 'artists=Weezer, Black Keys', http://localhost:9292/playlists</code>"
  end
  
  # ACTION/IMPLEMENTATION
  service.implementation do
    p = Playlist.build_from_artists(params[:artists])
    if p.save
      p.to_json
    end
  end
end
