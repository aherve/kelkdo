class HomeController < ApplicationController
  def index
    @gift = Gift.new(author: current_user)

    @name = if user_signed_in?
              current_user.name
            else
              'Vaillant(e) inconnu(e)'
            end
  end

end
