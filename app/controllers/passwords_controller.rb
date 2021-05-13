class PasswordsController < ApplicationController
  skip_before_action :authorized_child, :authorized_parent
  def forgot
    parent = Parent.find_by(email: params[:_json])
    if parent
      render json: {
        alert: "If this user exists, we have sent you a password reset email."
      }
      parent.send_password_reset
    else
      render json: {
        alert: "If this user exists, we have sent you a password reset email."
      }
    end
  end

  def reset
    parent = Parent.find_by(password_reset_token: params[:token], email: params[:email])
    if parent.present? && parent.password_token_valid?
      if parent.reset_password(params[:password])
        render json: {
          alert: "Your password has been successfuly reset!"
        }
        session[:parent_id] = parent.id
      else
        render json: { error: parent.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: {error:  ['Link not valid or expired. Try generating a new link.']}, status: :not_found
    end
  end

end