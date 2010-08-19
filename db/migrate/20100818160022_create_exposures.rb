class CreateExposures < ActiveRecord::Migration
  def self.up
    create_table :exposures do |t|
      t.datetime :birth
      t.datetime :death
      t.integer :stream_id
      t.timestamps
    end
  end
  
  def self.down
    drop_table :exposures
  end
end
