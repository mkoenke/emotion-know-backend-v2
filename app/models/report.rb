class Report < ApplicationRecord
    belongs_to :parent
    belongs_to :journal_entry
end
