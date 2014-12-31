class AddNotificationTimeToHabit < ActiveRecord::Migration
  def change
    add_column :habits, :notification_time, :datetime
  end
end
