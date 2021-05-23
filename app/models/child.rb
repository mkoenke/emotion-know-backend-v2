class Child < ApplicationRecord
    has_secure_password
    belongs_to :parent 
    has_many :video_entries
    has_many :video_reports, through: :video_entries

    validates :username, uniqueness: { case_sensitive: false }
end
