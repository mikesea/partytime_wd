require 'test_helpers'

class PlaylistsCreateSpec < MiniTest::Spec
  before :each do
    DatabaseCleaner.start
  end

  after :each do
    DatabaseCleaner.clean
  end

  let(:artists) { ["Weezer", "Bon Iver", "The Black Keys"]}

  it "performs request" do
    TestApi.post "/playlists"
    assert_api_response
  end

  it "returns a new playlist" do
    TestApi.post "/playlists"
    assert TestApi.json_response["id"]
  end

  it "returns a new playlist with 15 tracks" do
    TestApi.post "playlists", artists: [artists]
    assert_equal 15, TestApi.json_response["tracks"].length
  end
end
