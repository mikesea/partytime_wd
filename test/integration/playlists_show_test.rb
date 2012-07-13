require 'test_helpers'

class PlaylistsShowSpec < MiniTest::Spec
  before :each do
    DatabaseCleaner.start
  end

  after :each do
    DatabaseCleaner.clean
  end

  let(:playlist) { FactoryGirl.create(:playlist) }

  it "performs request" do
    TestApi.get "/playlists/:id", id: playlist.id
    assert_api_response
  end

  it "returns the same id of the requested playlist" do
    TestApi.get "/playlists/:id", id: playlist.id
    assert_equal TestApi.json_response["id"], playlist.id
  end

  describe "playlist tracks" do
    let(:playlist_with_tracks) { FactoryGirl.create(:playlist_with_tracks) }

    it "returns the playlist's tracks" do
      TestApi.get "/playlists/:id", id: playlist_with_tracks.id
      assert TestApi.json_response["tracks"].length
    end

    it "returns as many tracks are in the playlist" do
      TestApi.get "/playlists/:id", id: playlist_with_tracks.id
      assert_equal TestApi.json_response["tracks"].length, playlist_with_tracks.tracks.length
    end
  end
end
