class AddSessionsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :legacy_session_table do |t|
      t.string :session_id, :null => false
      t.text :data
      t.timestamps
    end

    add_index :legacy_session_table, :session_id, :unique => true
    add_index :legacy_session_table, :updated_at
  end
end
