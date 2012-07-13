class AddPlaylistIdToTracks < ActiveRecord::Migration
  def self.up
    add_column :tracks, :playlist_id, :integer
  end

  def self.down
  end
end
