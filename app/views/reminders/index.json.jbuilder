json.array!(@reminders) do |reminder|
  json.extract! reminder, :id, :user_id, :title, :text, :recurring, :trigger_at
  json.url reminder_url(reminder, format: :json)
end
