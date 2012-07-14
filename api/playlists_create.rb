describe_service "playlists" do |service|
  service.formats   :json
  service.http_verb :post
  service.disable_auth # on by default
  
  # INPUT
  service.param do |p|
    p.array :artists do |artist|
      artist.string :artist_name,
                    doc: "The name of an artist used to recommend tracks for the playlist",
                    required: true,
                    null: false
    end
  end
  
  # OUTPUT
  service.response do |response|
    response.object do |playlist|
      playlist.integer :id, doc: "The ID of the track that has been deleted."
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
    doc.overall <<-DOC
    This service accepts a list of musical <code>artists</code>,
    and then builds 15 track playlist with similarities to the provided <code>artists</code>.
    DOC
    doc.param :artists, "An list artists to use for track recommendations."
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
