class Growtheblurb < ActiveRecord::Migration
  def self.up
    change_column :exposures, :blurb, :text
  end

  def self.down
    change_column :exposures, :blurb, :string
  end
end
