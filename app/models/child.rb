class Child < ApplicationRecord
    has_secure_password
    belongs_to :parent 
    has_many :video_entries
    has_many :video_reports, through: :video_entries

    validates :username, uniqueness: { case_sensitive: false }

    def send_password_reset
        self.password_reset_token = generate_base64_token
        self.password_reset_sent_at = Time.zone.now
        save!
        ParentMailer.password_reset(self.parent).deliver_now
     end
 
     def password_token_valid?
         (self.password_reset_sent_at + 1.hour) > Time.zone.now
     end
 
     def reset_password(password)
         self.password_reset_token = nil
         self.password = password
         save!
     end
 
     private
 
     def generate_base64_token
         test = SecureRandom.urlsafe_base64
     end
end
