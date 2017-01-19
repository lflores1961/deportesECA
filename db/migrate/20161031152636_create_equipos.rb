class CreateEquipos < ActiveRecord::Migration[5.0]
  def change
    create_table :equipos do |t|
      t.string :name
      t.integer :categoria
      t.string :deporte
      t.string :rama
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
