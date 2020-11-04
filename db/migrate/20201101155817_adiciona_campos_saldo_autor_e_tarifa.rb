class AdicionaCamposSaldoAutorETarifa < ActiveRecord::Migration[6.0]
  def change
    add_column :transferencias, :saldo_conta, :numeric
    add_column :transferencias, :tarifa, :numeric
  end
end
