class GiftsController < ApplicationController

  respond_to :html
  before_action :count_gifts, :get_name
  before_action :authenticate_user!

  def get_name
    @name = if user_signed_in?
              current_user.name
            else
              'Vaillant(e) inconnu(e)'
            end
  end

  def count_gifts
    #@gifts_count = Gift.where(author: current_user).count
    @gifts_count = Gift.count
  end

  def index
    @gift = Gift.new(author: current_user)
  end

  def create
    @gift = Gift.new(gift_params)
    @gift.author = current_user
    if @gift.save
      redirect_to root_path
    else
      render template: 'gifts/index'
    end
  end

  private

  def gift_params
    params.require(:gift).permit(:name, :recipient, :context)
  end

end
