class AudioReport < ApplicationRecord
    belongs_to :parent
    belongs_to :audio_entry   
end
