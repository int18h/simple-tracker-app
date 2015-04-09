class IssueSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :user_id, :project_id
end
