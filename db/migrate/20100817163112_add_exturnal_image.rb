class AddExturnalImage < ActiveRecord::Migration
  def self.up
    add_column :promotions, :external_image_url, :string
  end

  def self.down
    remove_column :promotions, :external_image_url
  end
end
