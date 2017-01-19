class Deporte < ApplicationRecord

  def self.to_csv(options = {})
    desired_columns = ["id", "nombre"]
    CSV.generate(options) do |csv|
      csv << desired_columns
      all.each do |deporte|
        csv << deporte.attributes.values_at(*desired_columns)
      end
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      deporte = find_by_id(row["id"]) || new
      deporte.attributes = row.to_hash
      deporte.save!
    end
  end

end
