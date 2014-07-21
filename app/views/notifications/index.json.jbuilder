json.array!(@notifications) do |notification|
  json.extract! notification, :id, :user, :reminder_id, :text, :dispatched, :trigger_at
  json.url notification_url(notification, format: :json)
end
