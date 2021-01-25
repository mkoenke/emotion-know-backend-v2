class Parent < ApplicationRecord
    has_secure_password
    has_one :child
    has_many :journal_entries, through: :child
    # has_many :reports
    # has_many :reports, through: :journal_entries
end
