class RemoveDeporteFromCategorias < ActiveRecord::Migration[5.0]
  def change
    remove_column :categorias, :deporte, :string
  end
end
