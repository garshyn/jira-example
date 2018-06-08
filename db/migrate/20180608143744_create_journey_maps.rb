class CreateJourneyMaps < ActiveRecord::Migration[5.2]
  def change
    create_table :journey_maps do |t|
      t.string :title, limit: 200

      t.timestamps
    end
    add_index :journey_maps, :title
  end
end
