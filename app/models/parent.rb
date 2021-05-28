class Parent < ApplicationRecord
    has_secure_password
    has_many :children
    has_many :video_reports

    validates_presence_of :email, :password_digest
    validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
    validates :email, uniqueness: { case_sensitive: false }

    def send_password_reset
        self.password_reset_token = generate_base64_token
        self.password_reset_sent_at = Time.zone.now
        save!
        ParentMailer.password_reset(self).deliver_now
    end

    def send_password_reset_for_child
        self.password_reset_token = generate_base64_token
        self.password_reset_sent_at = Time.zone.now
        save!
        ChildMailer.password_reset_for_child(self).deliver_now
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
