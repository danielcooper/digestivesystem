class CreatePromotions < ActiveRecord::Migration
  def self.up
    create_table :promotions do |t|
      t.string :type
      t.string :title
      t.text :blurb
      t.string :resource_url
      t.timestamps
    end
  end
  
  def self.down
    drop_table :promotions
  end
end
