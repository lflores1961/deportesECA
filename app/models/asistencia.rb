class Asistencia < ApplicationRecord
  belongs_to :evento
  belongs_to :player
  validates :evento_id, :player_id, :tipo, presence: true
end
