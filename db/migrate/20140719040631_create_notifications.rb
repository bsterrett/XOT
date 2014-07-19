class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :reminder_id
      t.string :title
      t.string :text
      t.boolean :dispatched
      t.timestamp :trigger_at

      t.timestamps
    end
  end
end
