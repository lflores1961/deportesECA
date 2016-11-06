class Player < ApplicationRecord
  belongs_to :equipo
  default_scope -> { order(:apellidoPaterno) }
  validates :equipo_id, :apellidoPaterno, :fechaNacimiento, presence: true

end
