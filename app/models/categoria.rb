class Categoria < ApplicationRecord
  validates :nombre, :limInferior, :limSuperior, presence: true

  def self.to_csv(options = {})
    desired_columns = ["id", "nombre", "limInferior", "limSuperior"]
    CSV.generate(options) do |csv|
      csv << desired_columns
      all.each do |categor|
        csv << categor.attributes.values_at(*desired_columns)
      end
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      categoria = find_by_id(row["id"]) || new
      categoria.attributes = row.to_hash
      categoria.save!
    end
  end

end
