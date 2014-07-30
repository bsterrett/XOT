class AddRecurrencePeriodToReminders < ActiveRecord::Migration
  def change
    add_column :reminders, :recurrence_period, :integer
  end
end
