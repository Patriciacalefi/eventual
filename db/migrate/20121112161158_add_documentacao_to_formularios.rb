class AddDocumentacaoToFormularios < ActiveRecord::Migration
  def self.up
    add_column :formularios, :documentacao_entregue, :boolean, :default => 0
  end

  def self.down
    remove_column :formularios, :documentacao_entregue
  end
end
