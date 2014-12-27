class HomeController < ApplicationController
  def index
    @name = if user_signed_in?
              current_user.name
            else
              'Vaillant(e) inconnu(e)'
            end
  end
end
