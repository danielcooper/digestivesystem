class AddDetailsToExposures < ActiveRecord::Migration
  def self.up
    add_column :exposures, :title, :string
    add_column :exposures, :blurb, :string
    add_column :exposures, :image, :string
  end

  def self.down
    remove_column :exposures, :title
    remove_column :exposures, :blurb
    remove_column :exposures, :image
  end
end
