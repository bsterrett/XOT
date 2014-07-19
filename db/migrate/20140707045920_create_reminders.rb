class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.integer :user_id
      t.string :title
      t.string :text
      t.boolean :recurring
      t.timestamp :trigger_at

      t.timestamps
    end
    add_index :reminders, :user_id
  end
end
