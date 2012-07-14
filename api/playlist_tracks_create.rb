describe_service "playlists/:playlist_id/tracks" do |service|
  service.formats   :json
  service.http_verb :post
  service.disable_auth # on by default
  
  # INPUT
  service.params do |p|
    p.integer :playlist_id,
              doc: "The ID of the playlist to which the track belongs.",
              null: false,
              required: true
    p.namespace :track do |track|
      track.string :title,
                    doc: "The title of the track.",
                    required: true, null: false
      track.string :album_title,
                    doc: "The title of the album to which the track belongs.",
                    required: true, null: false
      track.string :artist_name,
                    doc: "The name of the track's artist.",
                    required: true, null: false
      track.string :rdio_id,
                    doc: "The Rdio ID of the track.",
                    required: true, null: false
    end
  end
  
  # OUTPUT
  service.response do |response|
    response.object do |track|
        track.string :title, doc: "The title of the track."
        track.string :album_title, doc: "The title of the album to which the track belongs."
        track.string :artist_name, doc: "The name of the track's artist."
        track.string :rdio_id, doc: "The Rdio ID of the track."
    end
  end
  
  # DOCUMENTATION
  service.documentation do |doc|
    doc.overall "This service adds a track to an existing playlist."
    doc.example <<-DOC
    <code>
      curl -d 'track[title]=song1&track[album_title]=album1&track[artist_name]=artist1&track[rdio_id]=t123' http://localhost:9292/playlists/1/tracks
    </code>
    DOC
  end
  
  # ACTION/IMPLEMENTATION
  service.implementation do
    playlist = Playlist.where(id: params[:playlist_id]).first
    if playlist && track = playlist.tracks.build(params[:track])
      playlist.save
      status 201; track.to_json
    else
      status 400
    end
  end
end
