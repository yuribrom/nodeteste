class AddPasswordClientes < ActiveRecord::Migration[6.0]
  def change
    add_column :clientes, :password, :string
  end
end
