json.array!(@notifications) do |notification|
  json.extract! notification, :id, :user_id, :reminder_id, :text_content, :dispatched, :trigger_at
  json.url notification_url(notification, format: :json)
end
