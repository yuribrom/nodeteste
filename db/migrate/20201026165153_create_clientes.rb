class CreateClientes < ActiveRecord::Migration[6.0]
  def change
    create_table :clientes do |t|
      t.string :nome, null: false
      t.string :email, null: false
      t.integer :cpf, null: false
      t.integer :rg, null: false
      t.string :endereco, null: false
      t.date :data_nascimento

      t.timestamps
    end
    add_index :clientes, [:nome, :email, :cpf, :rg], unique: true
  end
end
