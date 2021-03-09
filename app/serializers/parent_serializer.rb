class ParentSerializer < ActiveModel::Serializer
  attributes :id, :email
  has_one :child
  has_many :video_reports

end
