class RenamePromotionToResource < ActiveRecord::Migration
  def self.up
    rename_table :promotions, :resources
  end

  def self.down
     rename_table :resources, :promotions
  end
end
