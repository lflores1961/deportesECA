class CreateEventos < ActiveRecord::Migration[5.0]
  def change
    create_table :eventos do |t|
      t.date :fecha
      t.string :tipo
      t.references :equipo, foreign_key: true
      t.string :comment

      t.timestamps
    end
    add_index :eventos, [:equipo_id, :fecha]
  end
end
