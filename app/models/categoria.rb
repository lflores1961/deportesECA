class Categoria < ApplicationRecord
  validates :nombre, :limInferior, :limSuperior, presence: true
end
