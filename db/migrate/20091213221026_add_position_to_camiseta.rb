class AddPositionToCamiseta < ActiveRecord::Migration
  def self.up
    add_column :camisetas, :position, :integer, :default => 0
  end

  def self.down
    remove_column :camisetas, :position
  end
end
