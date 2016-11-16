class Evento < ApplicationRecord
  belongs_to :equipo
  has_many :asistencias, dependent: :destroy
  has_many :players, through: :asistencias
  validates :equipo_id, :fecha, :tipo, presence: true
end
