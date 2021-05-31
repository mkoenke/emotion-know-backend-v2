class ChildSerializer < ActiveModel::Serializer
  attributes :id, :username, :name, :image, :parent_email, :parent, :video_entries

  has_many :video_reports

  def parent_email
    self.object.parent.email
  end

  def video_entries
    self.object.video_entries
  end

end
