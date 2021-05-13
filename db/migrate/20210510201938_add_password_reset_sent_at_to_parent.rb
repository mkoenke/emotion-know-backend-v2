class AddPasswordResetSentAtToParent < ActiveRecord::Migration[6.0]
  def change
    add_column :parents, :password_reset_sent_at, :datetime
  end
end
