class ChangeColumnTipoForEventos < ActiveRecord::Migration[5.0]
  def change
		rename_column :eventos, :tipo, :tipoEvento
  end
end
