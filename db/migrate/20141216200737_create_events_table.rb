class CreateEventsTable < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.boolean :completed
      t.integer :repetitions
      t.references :habit
      t.timestamps
    end
  end
end
