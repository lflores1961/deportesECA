class Equipo < ApplicationRecord
  belongs_to :user
  has_many :players
  has_many :eventos, dependent: :destroy
  validates :user_id, :name, presence: true

  def self.to_csv(options = {})
    desired_columns = ["name", "categoria", "deporte", "rama", "user_id"]
    CSV.generate(options) do |csv|
      csv << desired_columns
      all.each do |equipo|
        csv << equipo.attributes.values_at(*desired_columns)
      end
    end
  end

end
