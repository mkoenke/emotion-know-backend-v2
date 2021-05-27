class ChildSerializer < ActiveModel::Serializer
  attributes :id, :username, :name, :image, :parent_email, :parent

  # Commented out to test video fetch limit upon login
  # has_many :video_entries

  def parent_email
    self.object.parent.email
  end

end
