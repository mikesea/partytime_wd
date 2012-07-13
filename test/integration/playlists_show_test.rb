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
end
