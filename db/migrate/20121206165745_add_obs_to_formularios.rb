class AddObsToFormularios < ActiveRecord::Migration
  def self.up
    add_column :formularios, :obs, :string
  end

  def self.down
    remove_column :formularios, :obs
  end
end
