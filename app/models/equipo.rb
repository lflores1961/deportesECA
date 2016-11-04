class Equipo < ApplicationRecord
  belongs_to :user
  validates :user_id, :name, presence: true
end
