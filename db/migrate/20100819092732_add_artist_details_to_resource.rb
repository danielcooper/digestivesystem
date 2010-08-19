class AddArtistDetailsToResource < ActiveRecord::Migration
  def self.up
    add_column :resources, :artist_gid, :string
    add_column :resources, :artist_name, :string
    add_column :exposures, :resource_id, :integer
  end

  def self.down
    remove_column :resources, :artist_gid
    remove_column :resources, :artist_name
    remove_column :exposures, :resource_id
  end
end


