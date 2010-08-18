class CreateBBCGalleryPromotions < ActiveRecord::Migration
  def self.up
    create_table :bbc_gallery_promotions do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :bbc_gallery_promotions
  end
end
