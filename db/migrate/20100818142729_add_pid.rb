class AddPid < ActiveRecord::Migration
  def self.up
		add_column :resources, :pid, :string
  end

  def self.down
		remove_column :resources, :pid, :string
  end
end
