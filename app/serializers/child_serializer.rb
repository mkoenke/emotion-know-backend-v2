class ChildSerializer < ActiveModel::Serializer
  attributes :id, :username, :name, :image, :parent_email, :parent

  has_many :video_reports

  def parent_email
    self.object.parent.email
  end

end
