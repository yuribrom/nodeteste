class CreateConta < ActiveRecord::Migration[6.0]
  def change
    create_table :contas do |t|
      t.references :cliente, null: false
      t.integer :numero, null: false
      t.numeric :saldo, null: false
      t.date :data_abertura, null: false
      t.integer :tipo, null: false
      t.date :data_encerramento

      t.timestamps
    end
  end
end
