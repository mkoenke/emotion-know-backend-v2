class ParentSerializer < ActiveModel::Serializer
  attributes :id, :email
  has_many :children
  has_many :video_reports

end
