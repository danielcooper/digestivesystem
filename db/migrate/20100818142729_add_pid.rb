class AddPid < ActiveRecord::Migration
  def self.up
		add_column :promotions, :pid, :string
  end

  def self.down
		remove_column :promotoins, :pid, :string
  end
end
