class JournalEntry < ApplicationRecord
    belongs_to :child
    has_one :report
end
