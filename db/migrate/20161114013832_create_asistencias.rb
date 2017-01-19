class CreateAsistencias < ActiveRecord::Migration[5.0]
  def change
    create_table :asistencias do |t|
      t.references :evento, foreign_key: true
      t.references :player, foreign_key: true
      t.string :tipo
      t.text :comment

      t.timestamps
    end
  end
end
