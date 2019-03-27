class HomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to prayers_path
    else 
      redirect_to landing_path
    end
  end
end
