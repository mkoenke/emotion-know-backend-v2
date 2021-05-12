class SessionsController < ApplicationController
  def get_current_parent
    if logged_in_parent?
      render json: current_user
    end
  end

end
