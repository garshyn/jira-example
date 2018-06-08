class CreateFields < ActiveRecord::Migration[5.2]
  def change
    create_table :fields do |t|
      t.string :type
      t.text :contents
      t.belongs_to :step, foreign_key: true

      t.timestamps
    end
    add_index :fields, :type
  end
end
