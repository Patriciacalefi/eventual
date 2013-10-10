class AddAtivoToFormularios < ActiveRecord::Migration
  def self.up
    add_column :formularios, :ativo, :boolean, :default => 0
  end

  def self.down
    remove_column :formularios, :ativo
  end
end
