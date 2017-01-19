class AddDoneBooltoEvento < ActiveRecord::Migration[5.0]
  def change
		add_column :eventos, :registrado, :boolean, default: false
  end
end
