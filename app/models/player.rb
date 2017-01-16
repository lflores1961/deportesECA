class Player < ApplicationRecord
  belongs_to :equipo
  has_many :eventos
  has_many :asistencias, through: :eventos
  #has_many :eventos, through: :asistencias
  default_scope -> { order(:apellidoPaterno) }
  validates :equipo_id, :apellidoPaterno, :fechaNacimiento, presence: true

  # Convert column data to comma separated values
  def self.to_csv(options = {})
    desired_columns = ["apellidoPaterno", "apellidoMaterno", "nombres", "fechaNacimiento", "equipo_id",
                        "seccion", "grupo", "genero", "beca"]
    CSV.generate(options) do |csv|
      csv << desired_columns
      all.each do |player|
        csv << player.attributes.values_at(*desired_columns)
      end
    end
  end

  # Save players.equipo_id to avoid players dependency with Equipo to crash the system
  # equipo must be assigned the special Equipo record '99 - NO DETERMINADO' id numbers
  def seguro(equipo)
    update_attribute(:equipo_id, equipo)
  end
end
