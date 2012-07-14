describe_service "playlists/:id" do |service|
  service.formats   :json
  service.http_verb :get
  service.disable_auth # on by default
  
  # INPUT
  service.param.integer :id,
                        doc: "The ID of the playlist to which the track belongs.",
                        null: false,
                        required: true
  
  # OUTPUT
  service.response do |response|
    response.object do |playlist|
      playlist.integer :id, doc: "The ID of the playlist that was fetched."
      playlist.array :tracks do |track|
        track.string :title, doc: "The title of the track."
        track.string :album_title, doc: "The title of the album to which the track belongs."
        track.string :artist_name, doc: "The name of the track's artist."
        track.string :rdio_id, doc: "The Rdio ID of the track."
      end
    end
  end
  
  # DOCUMENTATION
  service.documentation do |doc|
    doc.overall "This service returns a playlist."
    doc.param :id, "The ID of the playlist being fetched (e.g., 123)."
    doc.example "<code>curl 'http://localhost:9292/playlists/1'</code>"
  end
  
  # ACTION/IMPLEMENTATION
  service.implementation do
    Playlist.where(id: params[:id]).first.to_json
  end
end
