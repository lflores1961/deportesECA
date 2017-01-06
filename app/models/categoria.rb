class Categoria < ApplicationRecord
  validates :nombre, :limInferior, :limSuperior, presence: true

  def self.to_csv(options = {})
    desired_columns = ["nombre", "limInferior", "limSuperior"]
    CSV.generate(options) do |csv|
      csv << desired_columns
      all.each do |categor|
        csv << categor.attributes.values_at(*desired_columns)
      end
    end
  end
  
end
