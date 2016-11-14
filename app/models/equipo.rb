class Equipo < ApplicationRecord
  belongs_to :user
  has_many :players
  has_many :eventos, dependent: :destroy
  validates :user_id, :name, presence: true
end
