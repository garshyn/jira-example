class CreateSteps < ActiveRecord::Migration[5.2]
  def change
    create_table :steps do |t|
      t.string :title, limit: 100
      t.text :description
      t.belongs_to :journey_map, foreign_key: true

      t.timestamps
    end
    add_index :steps, :title
  end
end
