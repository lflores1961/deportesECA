class Equipo < ApplicationRecord
  belongs_to :user
  has_many :players
  validates :user_id, :name, presence: true
end
