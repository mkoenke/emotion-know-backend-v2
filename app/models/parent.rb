class Parent < ApplicationRecord
    has_secure_password
    has_one :child
    has_many :reports
    has_many :audio_reports
    has_many :video_reports
end
