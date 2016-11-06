class CreatePlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :players do |t|
      t.string :apellidoPaterno
      t.string :apellidoMaterno
      t.string :nombres
      t.date :fechaNacimiento
      t.references :equipo, foreign_key: true
      t.string :seccion
      t.string :grupo
      t.string :genero
      t.boolean :beca, default: false

      t.timestamps
    end
    add_index :players, [:apellidoPaterno, :apellidoMaterno]
  end
end
