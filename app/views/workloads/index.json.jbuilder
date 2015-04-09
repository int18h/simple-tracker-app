json.array!(@workloads) do |workload|
  json.extract! workload, :id, :description, :hours, :issues, :users
  json.url workload_url(workload, format: :json)
end
