class GiftsController < ApplicationController

  respond_to :html

  def index
    @gifts_count = Gift.where(author: current_user).count
    @gift = Gift.new(author: current_user)

    @name = if user_signed_in?
              current_user.name
            else
              'Vaillant(e) inconnu(e)'
            end
  end

  def new
  end

  def create
    @gift = Gift.new(gift_params)
    @gift.author = current_user
    if @gift.save
      redirect_to root_path
    else
      respond_with(@gift)
    end
  end

  private

  def gift_params
    params.require(:gift).permit(:name, :recipient, :context)
  end

end
