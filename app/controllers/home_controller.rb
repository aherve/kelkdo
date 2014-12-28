class HomeController < ApplicationController
  def index
    redirect_to gifts_path if user_signed_in?
  end
end
