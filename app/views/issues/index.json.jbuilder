json.array!(@issues) do |issue|
  json.extract! issue, :id, :name, :description, :user_id, :project_id
  json.url issue_url(issue, format: :json)
end
