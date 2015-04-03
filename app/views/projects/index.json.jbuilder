json.array!(@projects) do |project|
  json.extract! project, :id, :name, :status, :finished_at, :user_id, :team_id
  json.url project_url(project, format: :json)
end
