class TabelaTransferenciaClienteConta < ActiveRecord::Migration[6.0]
  def self.up
    create_table :transferencias do |t|
      t.references :cliente, :conta
      t.integer :tipo, null: false
      t.numeric :valor, null: false
      t.timestamps
    end
  end

  def self.down
    drop_table :transferencias
  end
end
