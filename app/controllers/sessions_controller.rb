class SessionsController < ApplicationController
  skip_before_action :authorized_child, :authorized_parent

  def get_current_parent
    puts "HERE IS CUURENT PARENT: #{current_parent}"

    if logged_in_parent?
      puts "HERE IS CUURENT PARENT: #{current_parent}"
      render json: current_parent
    end
  end

  const arrow = () => { return}

end
