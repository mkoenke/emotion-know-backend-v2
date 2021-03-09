class Parent < ApplicationRecord
    has_secure_password
    has_one :child
    has_many :video_reports
end
