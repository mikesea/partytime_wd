describe_service "playlists/:id" do |service|
  service.formats   :json
  service.http_verb :get
  service.disable_auth # on by default
  
  # INPUT
  service.param.integer :id
  
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
    doc.overall "This service returns a playlist."
    doc.example "<code>curl 'http://localhost:9292/playlists/123'</code>"
  end
  
  # ACTION/IMPLEMENTATION
  service.implementation do
    Playlist.where(id: params[:id]).first.to_json
  end
end
