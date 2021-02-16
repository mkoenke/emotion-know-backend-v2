class ChildSerializer < ActiveModel::Serializer
  attributes :id, :username, :image, :parent_email, :parent

  has_many :journal_entries
  has_many :audio_entries
  has_many :video_entries

  def parent_email
    self.object.parent.email
  end

end
