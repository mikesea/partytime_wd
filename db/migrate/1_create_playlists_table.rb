class CreatePlaylistsTable < ActiveRecord::Migration
  def self.up
    create_table :playlists do |t|
      t.timestamps
    end
  end

  def self.down
  end
end
