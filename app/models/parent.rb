class Parent < ApplicationRecord
    has_secure_password
    has_many :children
    has_many :video_reports
end
