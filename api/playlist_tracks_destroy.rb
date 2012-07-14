describe_service "playlists/:playlist_id/tracks/:id" do |service|
  service.formats   :json
  service.http_verb :delete
  service.disable_auth # on by default
  
  # INPUT
  service.params do |p|
    p.integer :playlist_id,
              doc: "The ID of the playlist to which the track belongs.",
              required: true,
              null: false
    p.integer :id,
              doc: "The ID of the track to be deleted.",
              required: true,
              null: false
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
    doc.overall "This service removes a track from an existing playlist."
    doc.example "<code>curl -X DELETE http://localhost:9292/playlists/1/tracks/20</code>"
  end
  
  # ACTION/IMPLEMENTATION
  service.implementation do
    track = Track.where(id: params[:id]).first
    if track && track.playlist.id == params[:playlist_id]
      track.destroy.to_json
    else
      status 400
    end
  end
end
