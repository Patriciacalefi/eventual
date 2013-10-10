class CreateApuracaos < ActiveRecord::Migration
  def self.up
    create_table :apuracaos do |t|
      t.references :formulario
      t.decimal :n_pontos, :default => 0, :precision => ('10,3')
      t.decimal :nota_prova, :default => 0, :precision => ('10,3')
      t.decimal :total, :default => 0, :precision => ('10,3')
      t.string  :curso
      t.boolean :aprovada
      t.timestamps
    end
  end

  def self.down
    drop_table :apuracaos
  end
end
