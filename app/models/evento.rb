class Evento < ApplicationRecord
  belongs_to :equipo
  has_many :asistencias, dependent: :destroy
  accepts_nested_attributes_for :asistencias
	scope :done, -> { where(registrado: true) }
  # has_many :players, through: :asistencias
  # has_many :players, through: :equipo
  # accepts_nested_attributes_for :players
  validates :equipo_id, :fecha, :tipoEvento, presence: true

  # set alias for simple calendar format
  def start_time
    self.fecha
  end

  # Convert column data to comma separated values
  def self.to_csv(options = {})
    desired_columns = ["fecha", "tipoEvento", "equipo_id", "comment", "registrado"]
    CSV.generate(options) do |csv|
      csv << desired_columns
      all.each do |evento|
        csv << evento.attributes.values_at(*desired_columns)
      end
    end
  end
  
end
