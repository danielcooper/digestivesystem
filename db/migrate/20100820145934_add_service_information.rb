class AddServiceInformation < ActiveRecord::Migration
  def self.up
		add_column :services, :url, :string
		add_column :services, :schedule, :string
		add_column :services, :background_image, :string
  end

  def self.down
		remove_column :services, :url
		remove_column :services, :schedule
		remove_column :services, :background_image
  end
end
