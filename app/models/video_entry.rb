class VideoEntry < ApplicationRecord
    include Rails.application.routes.url_helpers
    has_one_attached :video, dependent: :destroy
    belongs_to :child
    has_one :video_report

    def url
        if self.video.attached?
          "http://localhost:3000/#{Rails.application.routes.url_helpers.rails_blob_path(self.video, only_path: true)}"
        else
          nil
        end
    end
end
