class Evento < ApplicationRecord
  belongs_to :equipo
  has_many :asistencias, dependent: :destroy
  accepts_nested_attributes_for :asistencias
	scope :done, -> { where(registrado: true) }
  # has_many :players, through: :asistencias
  # has_many :players, through: :equipo
  # accepts_nested_attributes_for :players
  validates :equipo_id, :fecha, :tipoEvento, presence: true

  def start_time
    self.fecha
  end
end
