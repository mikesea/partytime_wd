describe_service "playlists/:playlist_id/tracks" do |service|
  service.formats   :json
  service.http_verb :post
  service.disable_auth # on by default
  
  # INPUT
  service.params do |p|
    p.integer :playlist_id
    p.namespace :track do |track|
      track.string :title
      track.string :album_title
      track.string :artist_name
      track.string :rdio_id
    end
  end
  
  # OUTPUT
  service.response do |response|
    response.object do |track|
      track.string :title
      track.string :album_title
      track.string :artist_name
      track.string :rdio_id
    end
  end
  
  # DOCUMENTATION
  service.documentation do |doc|
    doc.overall "This service adds a track to an existing playlist."
    doc.example "<code>
      curl -d 'track[title]=song1&track[album_title]=album1&track[artist_name]=artist1&track[rdio_id]=t123' http://localhost:9292/playlists/1/tracks</code>"
  end
  
  # ACTION/IMPLEMENTATION
  service.implementation do
    playlist = Playlist.where(id: params[:playlist_id]).first
    if track = playlist.tracks.create(params[:track])
      status 201; track.to_json
    else
      status 400
    end
  end
end
