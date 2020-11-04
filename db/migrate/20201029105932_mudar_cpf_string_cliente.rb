class MudarCpfStringCliente < ActiveRecord::Migration[6.0]
  def change
    change_column(:clientes, :cpf, :string)
  end
end
