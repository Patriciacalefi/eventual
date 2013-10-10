class CreateFormularios < ActiveRecord::Migration
  def self.up
    create_table :formularios do |t|
      t.string :nome
      t.date :dt_nasc
      t.string :estado_civil
      t.integer :n_filhos
      t.string :endereco
      t.integer :numero
      t.string :complemento
      t.string :bairro
      t.string :cidade
      t.integer :cep
      t.integer :pis
      t.string :cpf
      t.string :rg
      t.integer :telefone
      t.integer :celular
      t.string :email
      t.string :graduacao
      t.string :opcao
      t.references :disciplina
      t.string :horario
      t.boolean :exerce_funcao, :default => 0
      t.decimal :n_pontos, :default => 0, :precision => ('10,3')
      t.decimal :nota_prova, :default => 0, :precision => ('10,3')
      t.decimal :total, :default => 0, :precision => ('10,3')

      t.timestamps
    end
  end

  def self.down
    drop_table :formularios
  end
end
