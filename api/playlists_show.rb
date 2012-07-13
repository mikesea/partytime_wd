describe_service "playlists/:id" do |service|
  service.formats   :json
  service.http_verb :get
  service.disable_auth # on by default
  
  # INPUT
  service.param.integer :id
  
  # OUTPUT
  service.response do |response|
    response.object do |obj|
      obj.integer :id
      obj.array :tracks
    end
  end
  
  # DOCUMENTATION
  service.documentation do |doc|
    doc.overall "This service returns a playlist."
    doc.example "<code>curl 'http://localhost:9292/playlists/123'</code>"
  end
  
  # ACTION/IMPLEMENTATION
  service.implementation do
    Playlist.find(params[:id]).to_json
  end
end
