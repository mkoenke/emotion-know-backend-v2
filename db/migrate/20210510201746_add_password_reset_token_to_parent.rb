class AddPasswordResetTokenToParent < ActiveRecord::Migration[6.0]
  def change
    add_column :parents, :password_reset_token, :string
  end
end
