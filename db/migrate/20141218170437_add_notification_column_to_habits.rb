class AddNotificationColumnToHabits < ActiveRecord::Migration
  def change
    add_column :habits, :notifications, :boolean
  end
end
