class Player < ApplicationRecord
  belongs_to :equipo
  has_many :asistencias
  has_many :eventos, through: :asistencias
  default_scope -> { order(:apellidoPaterno) }
  validates :equipo_id, :apellidoPaterno, :fechaNacimiento, presence: true
end