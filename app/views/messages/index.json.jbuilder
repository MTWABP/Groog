json.array!(@messages) do |message|
  json.extract! message, :id, :body, :user
end
