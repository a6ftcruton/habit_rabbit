class AddStartDateToHabit < ActiveRecord::Migration
  def change
    add_column :habits, :start_date, :datetime
  end
end
